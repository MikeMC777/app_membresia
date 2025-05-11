class CreateMeetings < ActiveRecord::Migration[7.1]
  def change
    create_table :meetings do |t|
      t.references :team, null: false, foreign_key: true
      t.string :title
      t.datetime :date
      t.integer :mode
      t.string :url
      t.string :location
      t.float :latitude
      t.float :longitude
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :meetings, :deleted_at
  end
end
