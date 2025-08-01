require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  let(:admin_user)     { create(:user, roles: ['admin']) }
  let(:secretary_user) { create(:user, roles: ['secretary']) }
  let(:member_user)    { create(:user, roles: ['user']) }

  let(:valid_attributes) do
    attributes_for(:member)
  end

  let(:invalid_attributes) do
    { first_name: '', email: '' }
  end

  before do
    sign_in admin_user
  end

  describe "GET #index" do
    it "permite al admin ver la lista" do
      member = create(:member)
      sign_in admin_user

      get :index

      expect(response).to be_successful
      expect(response.body).to include(member.first_name)
    end

    it "filtra por estado si se provee status" do
      active_member = create(:member, status: :active)
      inactive_member = create(:member, status: :inactive)

      get :index, params: { status: 'active' }
      expect(response.body).to include(member.first_name)
      expect(response.body).not_to include(inactive_member)
    end
  end

  describe "GET #show" do
    it "muestra un miembro" do
      member = create(:member)
      get :show, params: { id: member.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "permite acceder al formulario" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "permite acceder al formulario de edición" do
      member = create(:member)
      get :edit, params: { id: member.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "con atributos válidos" do
      it "crea un nuevo miembro" do
        expect {
          post :create, params: { member: valid_attributes }
        }.to change(Member, :count).by(1)
      end

      it "crea el miembro con estado simpatizante por defecto" do
        post :create, params: { member: valid_attributes.except(:status) }
        member = Member.last
        expect(member.status).to eq("sympathizer")
      end

      it "rechaza creación con estado diferente de simpatizante" do
        post :create, params: { member: valid_attributes.merge(status: "active") }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "redirige al nuevo miembro" do
        post :create, params: { member: valid_attributes }
        expect(response).to redirect_to(Member.last)
      end
    end

    context "con atributos inválidos" do
      it "renderiza el formulario nuevamente" do
        post :create, params: { member: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe "PUT #update" do
    let(:member) { create(:member) }

    context "con atributos válidos" do
      it "actualiza el miembro" do
        put :update, params: {
          id: member.id,
          member: { first_name: "Nuevo" }
        }
        member.reload
        expect(member.first_name).to eq("Nuevo")
      end

      it "redirige al miembro actualizado" do
        put :update, params: { id: member.id, member: valid_attributes }
        expect(response).to redirect_to(member)
      end
    end

    context "con atributos inválidos" do
      it "renderiza el formulario de edición" do
        put :update, params: { id: member.id, member: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe "DELETE #destroy" do
    it "aplica soft delete al miembro" do
      member = create(:member)
      expect {
        delete :destroy, params: { id: member.id }
      }.to change(Member, :count).by(-1)
      expect(Member.with_deleted.find_by(id: member.id)).to be_deleted
    end

    it "redirige al listado" do
      member = create(:member)
      delete :destroy, params: { id: member.id }
      expect(response).to redirect_to(members_url)
    end
  end
end
