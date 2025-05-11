class CreateManuals < ActiveRecord::Migration[7.1]
  def change
    create_table :manuals do |t|
      t.references :team, null: false, foreign_key: true
      t.integer :type
      t.string :url
      t.string :name
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :manuals, :deleted_at
  end
end
