require 'rails_helper'

RSpec.describe Member, type: :model do
  describe 'associations' do
    it { should have_many(:team_roles) }
    it { should have_many(:teams).through(:team_roles) }
    it { should have_many(:tasks_created).class_name('Task').with_foreign_key('created_by_id').dependent(:nullify) }
    it { should have_many(:tasks_assigned).class_name('Task').with_foreign_key('assigned_to_id').dependent(:nullify) }
    it { should have_many(:attendances).dependent(:destroy) }
    it { should have_many(:attendance_confirmations).dependent(:destroy) }
    it { should have_many(:task_comments).dependent(:destroy) }
    it { should have_one(:user).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:first_surname) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end

  describe 'enums' do
    it { should define_enum_for(:marital_status).with_values(single: 0, married: 1, divorced: 2, widowed: 3) }
    it { should define_enum_for(:gender).with_values(male: 0, female: 1) }
    it { should define_enum_for(:status).with_values(active: 0, inactive: 1, sympathizer: 2) }
  end

  describe 'soft delete' do
    it 'soft deletes the member instead of hard delete' do
      member = create(:member)
      member.destroy
      expect(described_class.with_deleted.find_by(id: member.id)).to be_deleted
    end
  end

  describe '#full_name' do
    it 'concatenates all name parts with spaces' do
      member = build(:member, first_name: "Juan", second_name: "Carlos", first_surname: "Pérez", second_surname: "García")
      expect(member.full_name).to eq("Juan Carlos Pérez García")
    end

    it 'omits nil name parts' do
      member = build(:member, first_name: "Ana", second_name: nil, first_surname: "López", second_surname: nil)
      expect(member.full_name).to eq("Ana López")
    end
  end

  describe '#active?' do
    it 'returns true if status is active' do
      member = build(:member, status: :active)
      expect(member.active?).to be true
    end

    it 'returns false if status is not active' do
      member = build(:member, status: :inactive)
      expect(member.active?).to be false
    end
  end
end
