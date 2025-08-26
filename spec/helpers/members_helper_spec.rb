# spec/helpers/members_helper_spec.rb
require "rails_helper"

RSpec.describe MembersHelper, type: :helper do
  # Para congelar el tiempo en tests del cálculo de edad
  include ActiveSupport::Testing::TimeHelpers

  describe "#member_status_text" do
    it "devuelve el texto humanizado del estado (active)" do
      member = build(:member, status: :active)
      expect(helper.member_status_text(member))
        .to eq(I18n.t("activerecord.attributes.member.statuses.active"))
    end

    it "devuelve el texto humanizado del estado (inactive)" do
      member = build(:member, status: :inactive)
      expect(helper.member_status_text(member))
        .to eq(I18n.t("activerecord.attributes.member.statuses.inactive"))
    end

    it "devuelve el texto humanizado del estado (sympathizer)" do
      member = build(:member, status: :sympathizer)
      expect(helper.member_status_text(member))
        .to eq(I18n.t("activerecord.attributes.member.statuses.sympathizer"))
    end
  end

  describe "#member_gender_text" do
    it "devuelve el texto humanizado del género (male)" do
      member = build(:member, gender: :male)
      expect(helper.member_gender_text(member))
        .to eq(I18n.t("activerecord.attributes.member.genders.male"))
    end

    it "devuelve el texto humanizado del género (female)" do
      member = build(:member, gender: :female)
      expect(helper.member_gender_text(member))
        .to eq(I18n.t("activerecord.attributes.member.genders.female"))
    end
  end

  describe "#member_marital_status_text" do
    it "devuelve el texto humanizado del estado civil" do
      member = build(:member, marital_status: :married)
      expect(helper.member_marital_status_text(member))
        .to eq(I18n.t("activerecord.attributes.member.marital_statuses.married"))
    end
  end

  describe "#member_full_name" do
    it "concatena los nombres y apellidos como en el modelo" do
      member = build(:member,
        first_name: "Ana",
        second_name: "María",
        first_surname: "Pérez",
        second_surname: "García"
      )
      expect(helper.member_full_name(member)).to eq("Ana María Pérez García")
    end

    it "omite en blanco y respeta el orden" do
      member = build(:member,
        first_name: "Ana",
        second_name: nil,
        first_surname: "Pérez",
        second_surname: ""
      )
      expect(helper.member_full_name(member)).to eq("Ana Pérez")
    end
  end

  describe "#member_age" do
    around do |ex|
      travel_to(Time.zone.parse("2025-01-10 12:00:00")) { ex.run }
    end

    it "calcula la edad cumplida si ya pasó el cumpleaños" do
      member = build(:member, birth_date: Date.new(1990, 1, 9))
      expect(helper.member_age(member)).to eq(35) # 1990-01-09 → 2025-01-10
    end

    it "calcula la edad cumplida si aún no pasó el cumpleaños" do
      member = build(:member, birth_date: Date.new(1990, 1, 11))
      expect(helper.member_age(member)).to eq(34) # cumple mañana
    end

    it "devuelve nil si no hay birth_date" do
      member = build(:member, birth_date: nil)
      expect(helper.member_age(member)).to be_nil
    end
  end
end
