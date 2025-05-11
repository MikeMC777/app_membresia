class CreatePermissions < ActiveRecord::Migration[7.1]
  def change
    create_table :permissions do |t|
      t.string :name
      t.text :description
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :permissions, :deleted_at
  end
end
