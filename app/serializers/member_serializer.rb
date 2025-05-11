class MemberSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :second_name, :first_surname, :second_surname, :email, :phone, :status, :birth_date, :baptism_date, :marital_status, :gender, :wedding_date, :membership_date, :address, :city, :state, :country, :deleted_at
end
