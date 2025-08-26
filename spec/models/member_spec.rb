# spec/models/member_spec.rb
require "rails_helper"
require "securerandom"

RSpec.describe Member, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:team_roles).dependent(:destroy) }
    it { is_expected.to have_many(:teams).through(:team_roles) }
    it { is_expected.to have_many(:tasks_created).class_name("Task").with_foreign_key("created_by_id").dependent(:nullify) }
    it { is_expected.to have_many(:tasks_assigned).class_name("Task").with_foreign_key("assigned_to_id").dependent(:nullify) }
    it { is_expected.to have_many(:attendances).dependent(:destroy) }
    it { is_expected.to have_many(:attendance_confirmations).dependent(:destroy) }
    it { is_expected.to have_many(:task_comments).dependent(:destroy) }
    it { is_expected.to have_one(:user).dependent(:destroy) }
  end

  describe "validations" do
    subject { build(:member) }

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:first_surname) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:birth_date) }

    it "validates uniqueness of email case-insensitively" do
      unique_part     = SecureRandom.hex(4)
      mixed_case_email = "Foo#{unique_part}@Example.COM"
      create(:member, email: mixed_case_email)
      duplicate = build(:member, email: mixed_case_email.downcase)
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:email]).to include(I18n.t("activerecord.errors.models.member.attributes.email.taken"))
    end

    it "normalizes email (downcases and strips whitespace)" do
      m = build(:member, email: "  TeSt@ExAmPlE.CoM  ")
      m.valid?
      expect(m.email).to eq("test@example.com")
    end

    context "on create" do
      it "requires initial status to be sympathizer" do
        m = build(:member, status: :active)
        m.valid?
        expect(m.errors[:status]).to include(/must start as sympathizer/i)
      end

      it "defaults to sympathizer when no status provided" do
        m = build(:member)
        expect(m.status).to eq("sympathizer")
        expect(m).to be_valid
        m.save!
        expect(m.status).to eq("sympathizer")
      end
    end
  end

  describe "enums" do
    it { is_expected.to define_enum_for(:marital_status).with_values(single: 0, married: 1, divorced: 2, widowed: 3, common_law_marriage: 4) }
    it { is_expected.to define_enum_for(:gender).with_values(male: 0, female: 1) }
    it { is_expected.to define_enum_for(:status).with_values(active: 0, inactive: 1, sympathizer: 2) }
  end

  describe "soft delete" do
    it "soft deletes the member instead of hard delete" do
      m = create(:member)
      m.destroy
      expect(Member.with_deleted.find(m.id)).to be_deleted
    end
  end

  describe "#full_name" do
    it "concatenates all name parts with spaces" do
      m = build(
        :member,
        first_name:     "Juan",
        second_name:    "Carlos",
        first_surname:  "Pérez",
        second_surname: "García"
      )
      expect(m.full_name).to eq("Juan Carlos Pérez García")
    end

    it "omits nil or blank name parts" do
      m = build(
        :member,
        first_name:     "Ana",
        second_name:    nil,
        first_surname:  "López",
        second_surname: ""
      )
      expect(m.full_name).to eq("Ana López")
    end
  end

  describe "status helpers" do
    it "returns true for active? when status is active" do
      expect(build(:member, status: :active).active?).to be true
    end

    it "returns false for active? when status is not active" do
      expect(build(:member, status: :inactive).active?).to be false
    end
  end

  describe ".with_upcoming_birthday_in_days" do
    let(:days)        { 2 }
    let(:today)       { Date.current }
    let(:target_date) { today + days.days }

    before do
      # Miembro activo que cumple en X días
      @active_member = create(:member, birth_date: target_date, status: :sympathizer)
      @active_member.update!(status: :active)

      # Miembro inactivo en la misma fecha
      @inactive_member = create(:member, birth_date: target_date, status: :sympathizer)
      @inactive_member.update!(status: :inactive)

      # Miembro activo en otra fecha (no debe aparecer)
      @other_member = create(
        :member,
        birth_date: today + (days + 3).days,
        status:     :sympathizer
      ).tap { |m| m.update!(status: :active) }
    end

    it "incluye solo a los miembros con cumpleaños en X días y excluye los demás" do
      result = Member.with_upcoming_birthday_in_days(days)

      expect(result).to include(@active_member, @inactive_member)
      expect(result).not_to include(@other_member)
    end
  end
end
