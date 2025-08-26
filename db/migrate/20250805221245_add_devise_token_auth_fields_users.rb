class AddDeviseTokenAuthFieldsUsers < ActiveRecord::Migration[7.1]
  class MigrationUser < ApplicationRecord
    self.table_name = "users"
  end

  def up
    # 1) Añadimos las columnas sin índice aún
    add_column :users, :provider, :string, null: false, default: "email"
    add_column :users, :uid,      :string, null: false, default: ""
    add_column :users, :tokens,   :json

    # 2) Backfill: llenar uid con algo único para cada usuario
    MigrationUser.reset_column_information
    MigrationUser.find_each do |u|
      # aquí uso el email como uid, garantiza unicidad
      u.update_columns(uid: u.email)
    end

    # 3) Ahora sí podemos crear el índice único sin violación
    add_index :users, [:uid, :provider], unique: true
  end

  def down
    remove_index  :users, [:uid, :provider]
    remove_column :users, :provider
    remove_column :users, :uid
    remove_column :users, :tokens
  end
end
