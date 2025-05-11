require 'rails_helper'

RSpec.describe MemberPolicy do
  let(:member) { create(:member) }

  let(:admin_user) { create(:user, roles: ['admin']) }
  let(:secretary_user) { create(:user, roles: ['secretary']) }
  let(:programmer_user) { create(:user, roles: ['programmer']) }

  describe 'permisos de miembros' do
    subject { described_class }

    permissions = %i[index? show? create? update? reactivate?]

    permissions.each do |permission|
      context permission.to_s do
        it 'permite al administrador' do
          expect(subject.new(admin_user, member).public_send(permission)).to be true
        end

        it 'permite al secretario' do
          expect(subject.new(secretary_user, member).public_send(permission)).to be true
        end

        it 'deniega al programador' do
          expect(subject.new(programmer_user, member).public_send(permission)).to be false
        end
      end
    end
  end

  describe '#destroy?' do
    subject { described_class }

    it 'permite al administrador' do
      expect(subject.new(admin_user, member).destroy?).to be true
    end

    it 'deniega al secretario' do
      expect(subject.new(secretary_user, member).destroy?).to be false
    end

    it 'deniega al programador' do
      expect(subject.new(programmer_user, member).destroy?).to be false
    end
  end
end
