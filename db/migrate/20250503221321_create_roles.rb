class CreateRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :roles do |t|
      t.string :name
      t.integer :scope
      t.text :description
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :roles, :deleted_at
  end
end
