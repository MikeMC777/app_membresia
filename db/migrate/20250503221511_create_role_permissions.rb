class CreateRolePermissions < ActiveRecord::Migration[7.1]
  def change
    create_table :role_permissions do |t|
      t.references :role, null: false, foreign_key: true
      t.references :permission, null: false, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :role_permissions, :deleted_at
  end
end
