class CreateAttendances < ActiveRecord::Migration[7.1]
  def change
    create_table :attendances do |t|
      t.references :member, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.integer :attendance_type
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :attendances, :deleted_at
  end
end
