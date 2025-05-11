class CreateAttendanceConfirmations < ActiveRecord::Migration[7.1]
  def change
    create_table :attendance_confirmations do |t|
      t.references :member, null: false, foreign_key: true
      t.references :meeting, null: false, foreign_key: true
      t.boolean :confirmed
      t.integer :attendance_type
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :attendance_confirmations, :deleted_at
  end
end
