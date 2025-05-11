class CreateMinutes < ActiveRecord::Migration[7.1]
  def change
    create_table :minutes do |t|
      t.references :meeting, null: false, foreign_key: true
      t.string :title
      t.text :agenda
      t.text :development
      t.datetime :ending_time
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :minutes, :deleted_at
  end
end
