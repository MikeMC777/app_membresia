# spec/requests/api/v1/members/index_spec.rb
require "rails_helper"

RSpec.describe "Api::V1::Members#index", type: :request do
  # Crea tres usuarios con roles diferentes y su miembro asociado.
  include_context "members api setup"

  # —————————————————————————————————————————————————————
  # BÁSICOS
  # —————————————————————————————————————————————————————
  context "as admin" do
    let!(:active_member) do
      create(:member, status: :sympathizer).tap { |m| m.update!(status: :active) }
    end
    let!(:inactive_member) do
      create(:member, status: :sympathizer).tap { |m| m.update!(status: :inactive) }
    end
    let!(:another_member) { create(:member, status: :sympathizer) }
    it "returns all members without filters" do
      get api_v1_members_path, headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      ids  = json.map { |m| m["id"] }
      expect(ids).to include(active_member.id, inactive_member.id)
    end

    it "filters by status" do
      get api_v1_members_path, params: { status: "active" }, headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.map { |m| m["id"] }).to contain_exactly(active_member.id)
    end

    it "does not include team_roles when flag not provided" do
      get api_v1_members_path, headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      json  = JSON.parse(response.body)
      found = json.find { |m| m["id"] == another_member.id }
      expect(found).not_to have_key("team_roles")
    end
  end

  context "as secretary" do
    it "can list members" do
      get api_v1_members_path, headers: auth_headers_for(secretary_user)
      expect(response).to have_http_status(:ok)
    end
  end

  context "as programmer (unauthorized)" do
    it "is forbidden from listing" do
      get api_v1_members_path, headers: auth_headers_for(programmer_user)
      expect(response).to have_http_status(:forbidden)
    end
  end

  context "as ordinary member user" do
    let!(:another_user)   { create(:user) }
    it "is forbidden from listing others" do
      get api_v1_members_path, headers: auth_headers_for(another_user)
      expect(response).to have_http_status(:forbidden)
    end
  end

  # —————————————————————————————————————————————————————
  # FILTROS POR CREATED_AT
  # —————————————————————————————————————————————————————
  describe "created_at range filters" do
    around { |ex| travel_to(Time.zone.parse("2025-01-10 15:00:00")) { ex.run } }

    let!(:m_old)  { Member.first.tap { |m| m.update_column(:created_at, 2.months.ago) } }
    let!(:m_mid)  { Member.second.tap { |m| m.update_column(:created_at, 15.days.ago) } }
    let!(:m_new)  { Member.third.tap { |m| m.update_column(:created_at, 2.days.ago) } }

    it "filters with created_from only" do
      get api_v1_members_path,
          params: { created_from: 20.days.ago.to_date },
          headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      ids = JSON.parse(response.body).map { |m| m["id"] }
      expect(ids).to include(m_mid.id, m_new.id)
      expect(ids).not_to include(m_old.id)
    end

    it "filters with created_to only" do
      get api_v1_members_path,
          params: { created_to: 20.days.ago.to_date },
          headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      ids = JSON.parse(response.body).map { |m| m["id"] }
      expect(ids).to include(m_old.id)
      expect(ids).not_to include(m_mid.id, m_new.id)
    end

    it "filters with created_from and created_to" do
      get api_v1_members_path,
          params: { created_from: 1.month.ago.to_date, created_to: 10.days.ago.to_date },
          headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      ids = JSON.parse(response.body).map { |m| m["id"] }
      expect(ids).to contain_exactly(m_mid.id)
    end
  end

  # —————————————————————————————————————————————————————
  # FILTROS POR BIRTH_DATE
  # —————————————————————————————————————————————————————
  describe "birth_date range filters" do
    let!(:b_old) { Member.first.tap { |m| m.update_column(:birth_date, Date.new(1970, 1, 1)) } }
    let!(:b_mid) { Member.second.tap { |m| m.update_column(:birth_date, Date.new(1990, 5, 10)) } }
    let!(:b_new) { Member.third.tap { |m| m.update_column(:birth_date, Date.new(2005, 12, 31)) } }

    it "birthdate_from only" do
      get api_v1_members_path,
          params: { birthdate_from: Date.new(1990, 1, 1) },
          headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      ids = JSON.parse(response.body).map { |m| m["id"] }
      expect(ids).to include(b_mid.id, b_new.id)
      expect(ids).not_to include(b_old.id)
    end

    it "birthdate_to only" do
      get api_v1_members_path,
          params: { birthdate_to: Date.new(1980, 1, 1) },
          headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      ids = JSON.parse(response.body).map { |m| m["id"] }
      expect(ids).to include(b_old.id)
      expect(ids).not_to include(b_mid.id, b_new.id)
    end

    it "filters with birthdate_from and birthdate_to" do
      get api_v1_members_path,
          params: { birthdate_from: Date.new(1970, 1, 1), birthdate_to: Date.new(1991, 1, 1) },
          headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      ids = JSON.parse(response.body).map { |m| m["id"] }
      expect(ids).to include(b_old.id, b_mid.id)
      expect(ids).not_to include(b_new.id)
    end
  end

  # —————————————————————————————————————————————————————
  # FILTRO: upcoming_in_days (cumpleaños exacto en N días) — sólo activos
  # —————————————————————————————————————————————————————
  describe "upcoming_in_days filter" do
    around { |ex| travel_to(Date.new(2025, 12, 25)) { ex.run } }

    let!(:b_closer) { Member.first.tap { |m| m.update_column(:birth_date, Date.new(1980, 12, 31)) } }
    let!(:b_close) { Member.second.tap { |m| m.update_column(:birth_date, Date.new(1990, 1, 1)) } }
    let!(:b_far) { Member.third.tap { |m| m.update_column(:birth_date, Date.new(1995, 8, 20)) } }

    it "returns only active members whose birthday is between today and N days" do
      get api_v1_members_path,
          params: { upcoming_in_days: 10 },
          headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      ids = JSON.parse(response.body).map { |m| m["id"] }
      expect(ids).to include(b_closer.id, b_close.id)
      expect(ids).not_to include(b_far.id)
    end

    it "returns no members if no upcoming birthdays between today and N days" do
      get api_v1_members_path,
          params: { upcoming_in_days: 5 },
          headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json).to be_empty
    end
  end

  # —————————————————————————————————————————————————————
  # FILTROS DE EDAD (age_min / age_max / ambos)
  # —————————————————————————————————————————————————————
  describe "age filters" do
    around { |ex| travel_to(Date.new(2025, 1, 1)) { ex.run } }

    let!(:age_20) { Member.first.tap { |m| m.update_column(:birth_date, Date.current.years_ago(20)) } }
    let!(:age_35) { Member.second.tap { |m| m.update_column(:birth_date, Date.current.years_ago(35)) } }
    let!(:age_50) { Member.third.tap { |m| m.update_column(:birth_date, Date.current.years_ago(50)) } }

    it "age_min" do
      get api_v1_members_path, params: { age_min: 30 }, headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      ids = JSON.parse(response.body).map { |m| m["id"] }
      expect(ids).to include(age_35.id, age_50.id)
      expect(ids).not_to include(age_20.id)
    end

    it "age_max" do
      get api_v1_members_path, params: { age_max: 30 }, headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      ids = JSON.parse(response.body).map { |m| m["id"] }
      expect(ids).to include(age_20.id)
      expect(ids).not_to include(age_35.id, age_50.id)
    end

    it "age_min + age_max" do
      get api_v1_members_path, params: { age_min: 30, age_max: 40 }, headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      ids = JSON.parse(response.body).map { |m| m["id"] }
      expect(ids).to contain_exactly(age_35.id)
    end
  end

  # —————————————————————————————————————————————————————
  # SEARCH (case-insensitive y acentos)
  # —————————————————————————————————————————————————————
  describe "search filter (accent/case insensitive)" do

    let!(:jose) { Member.first.tap { |m| m.update!(first_name: "José", first_surname: "Álvarez", email: "jose@example.com") } }
    let!(:maria) { Member.second.tap { |m| m.update!(first_name: "Maria", first_surname: "Alvarez", email: "maria@example.com") } }
    let!(:antonio) { Member.third.tap { |m| m.update!(first_name: "Antonio", first_surname: "Perez", email: "antonio@example.com") } }

    it "matches ignoring case" do
      get api_v1_members_path, params: { search: "mArIa" }, headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      ids = JSON.parse(response.body).map { |m| m["id"] }
      expect(ids).to include(maria.id)
      expect(ids).not_to include(jose.id)
    end

    it "matches ignoring accents" do
      get api_v1_members_path, params: { search: "Alvarez" }, headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      ids = JSON.parse(response.body).map { |m| m["id"] }
      expect(ids).to include(jose.id, maria.id)
    end
  end

  # —————————————————————————————————————————————————————
  # COMBINACIONES (2 y 3 filtros)
  # —————————————————————————————————————————————————————
  describe "combining filters" do
    around { |ex| travel_to(Date.new(2025, 1, 1)) { ex.run } }

    let!(:a30_active) { Member.first.tap { |m| m.update!(status: :active, birth_date: Date.current.years_ago(30), first_name: "Ana") } }
    let!(:a40_inactive) { Member.second.tap { |m| m.update!(status: :inactive, birth_date: Date.current.years_ago(40), first_name: "Andres") } }
    let!(:a50_active) { Member.third.tap { |m| m.update!(status: :active, birth_date: Date.current.years_ago(50), first_name: "Bruno") } }

    it "status + age_min" do
      get api_v1_members_path, params: { status: "active", age_min: 40 }, headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      ids = JSON.parse(response.body).map { |m| m["id"] }
      expect(ids).to contain_exactly(a50_active.id)
    end

    it "status + age_min + search" do
      get api_v1_members_path, params: { status: "active", age_min: 25, search: "ana" }, headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      ids = JSON.parse(response.body).map { |m| m["id"] }
      expect(ids).to contain_exactly(a30_active.id)
    end

    it "age range + created_from" do
      a50_active.update_column(:created_at, 3.days.ago)
      get api_v1_members_path, params: { age_min: 45, age_max: 55, created_from: 5.days.ago.to_date }, headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      ids = JSON.parse(response.body).map { |m| m["id"] }
      expect(ids).to contain_exactly(a50_active.id)
    end
  end

  # —————————————————————————————————————————————————————
  # PARÁMETROS NO PERMITIDOS / INVÁLIDOS
  # —————————————————————————————————————————————————————
  describe "invalid/unknown params" do
    it "ignores unknown param keys" do
      # En policy sólo se permiten ciertos filtros; "foo" debe ser ignorado.
      get api_v1_members_path, params: { foo: "bar" }, headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      # No explotó ni cambió el comportamiento.
    end

    it "invalid status value yields empty result (no 500)" do
      get api_v1_members_path, params: { status: "weird" }, headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      # `with_status` con valor inválido termina filtrando a status = NULL, lo que da vacío.
      expect(json).to be_an(Array)
    end

    it "age_min not numeric returns empty result (scope returns none)" do
      get api_v1_members_path, params: { age_min: "abc" }, headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json).to eq([])
    end

    it "age_max not numeric returns empty result (scope returns none)" do
      get api_v1_members_path, params: { age_max: "xyz" }, headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json).to eq([])
    end

    it "invalid date in created_from does not 500 (ignored by model guard)" do
      get api_v1_members_path, params: { created_from: "not-a-date" }, headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
    end

    it "ignores invalid birthdate_from" do
      get api_v1_members_path, params: { birthdate_from: "xxx" }, headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
    end
  end
end
