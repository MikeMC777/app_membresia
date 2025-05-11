class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :logo_url
      t.text :description
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :teams, :deleted_at
  end
end
