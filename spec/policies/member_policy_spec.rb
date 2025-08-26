require 'rails_helper'

RSpec.describe MemberPolicy do
  let!(:admin_role)     { create(:role, name: "admin") }
  let!(:secretary_role) { create(:role, name: "secretary") }
  let!(:programmer_role){ create(:role, name: "programmer") }

  let!(:admin_user) do
    user = create(:user)
    user.user_roles.create!(role: admin_role)
    user
  end

  let!(:secretary_user) do
    user = create(:user)
    user.user_roles.create!(role: secretary_role)
    user
  end

  let!(:programmer_user) do
    user = create(:user)
    user.user_roles.create!(role: programmer_role)
    user
  end

  let!(:member) { create(:member, status: :sympathizer) }

  # Usuario normal que es su propio member
  let!(:own_member) { create(:member, status: :sympathizer) }
  let!(:member_user) do
    user = create(:user, member: own_member)
    user
  end

  describe "action permissions" do
    context "index?" do
      it "permite admin" do
        expect(described_class.new(admin_user, Member).index?).to be true
      end

      it "permite secretary" do
        expect(described_class.new(secretary_user, Member).index?).to be true
      end

      it "deniega programmer" do
        expect(described_class.new(programmer_user, Member).index?).to be false
      end

      it "deniega usuario sin rol privilegiado" do
        random = create(:user, member: create(:member, status: :sympathizer))
        expect(described_class.new(random, Member).index?).to be false
      end
    end

    context "show?" do
      it "permite admin ver cualquier member" do
        expect(described_class.new(admin_user, member).show?).to be true
      end

      it "permite secretary ver cualquier member" do
        expect(described_class.new(secretary_user, member).show?).to be true
      end

      it "permite a un miembro ver su propio registro" do
        expect(described_class.new(member_user, own_member).show?).to be true
      end

      it "deniega a un miembro ver otro miembro" do
        expect(described_class.new(member_user, member).show?).to be false
      end

      it "deniega usuario sin rol privilegiado y sin relación" do
        random = create(:user, member: create(:member, status: :sympathizer))
        expect(described_class.new(random, member).show?).to be false
      end
    end

    [:create?, :update?, :reactivate?].each do |action|
      context "#{action}" do
        it "permite admin" do
          expect(described_class.new(admin_user, member).public_send(action)).to be true
        end

        it "permite secretary" do
          expect(described_class.new(secretary_user, member).public_send(action)).to be true
        end

        it "deniega programmer" do
          expect(described_class.new(programmer_user, member).public_send(action)).to be false
        end

        it "deniega usuario común" do
          random = create(:user, member: create(:member, status: :sympathizer))
          expect(described_class.new(random, member).public_send(action)).to be false
        end
      end
    end

    context "destroy?" do
      it "permite solo admin" do
        expect(described_class.new(admin_user, member).destroy?).to be true
        expect(described_class.new(secretary_user, member).destroy?).to be false
        expect(described_class.new(programmer_user, member).destroy?).to be false
      end
    end
  end

  describe "scope" do
    before do
      create_list(:member, 2, status: :sympathizer)
    end

    it "devuelve todos para admin" do
      resolved = described_class::Scope.new(admin_user, Member.all).resolve
      expect(resolved.count).to eq(Member.count)
    end

    it "devuelve todos para secretary" do
      resolved = described_class::Scope.new(secretary_user, Member.all).resolve
      expect(resolved.count).to eq(Member.count)
    end

    it "devuelve solo su propio member para un miembro normal" do
      resolved = described_class::Scope.new(member_user, Member.all).resolve
      expect(resolved).to contain_exactly(own_member)
    end

    it "devuelve none si user es nil" do
      resolved = described_class::Scope.new(nil, Member.all).resolve
      expect(resolved).to be_empty
    end
  end
end
