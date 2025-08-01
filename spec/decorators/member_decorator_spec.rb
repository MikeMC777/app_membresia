require 'rails_helper'

RSpec.describe MemberDecorator do
  let(:member) { build_stubbed(:member, first_name: "Ana", second_name: "Lucía", first_surname: "Pérez", second_surname: "Gómez", birth_date: Date.new(1990, 5, 10), membership_date: Date.new(2020, 1, 1), gender: "female", marital_status: "married", status: "active") }
  subject { described_class.new(member) }

  describe "#full_name" do
    it "concatenates all name parts" do
      expect(subject.full_name).to eq("Ana Lucía Pérez Gómez")
    end
  end

  describe "#birth_date_formatted" do
    it "returns formatted birth date" do
      expect(subject.birth_date_formatted).to eq("10/05/1990")
    end
  end

  describe "#membership_date_formatted" do
    it "returns formatted membership date" do
      expect(subject.membership_date_formatted).to eq("01/01/2020")
    end
  end

  describe "#gender_label" do
    it "returns correct gender label" do
      expect(subject.gender_label).to eq("Femenino")
    end
  end

  describe "#marital_status_label" do
    it "returns correct marital status label" do
      expect(subject.marital_status_label).to eq("Casado/a")
    end
  end

  describe "#status_badge" do
    it "returns HTML span for active status" do
      expect(subject.status_badge).to include("Activo")
      expect(subject.status_badge).to include("badge")
    end
  end
end
