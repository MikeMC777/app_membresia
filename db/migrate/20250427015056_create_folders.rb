class CreateFolders < ActiveRecord::Migration[7.1]
  def change
    create_table :folders do |t|
      t.string :name
      t.integer :size
      t.references :team, null: false, foreign_key: true
      t.references :parent_folder, null: false, foreign_key: { to_table: :folders }
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :folders, :deleted_at
  end
end
