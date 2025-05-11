class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.integer :event_type
      t.string :location
      t.string :image_url
      t.string :video_url
      t.datetime :start_date
      t.datetime :due_date
      t.datetime :publication_date
      t.integer :order
      t.boolean :banner
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :events, :deleted_at
  end
end
