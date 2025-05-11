class CreateMonthlySchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :monthly_schedules do |t|
      t.string :title
      t.text :description
      t.references :team, null: false, foreign_key: true
      t.string :scheduled_month
      t.string :status
      t.date :due_date
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :monthly_schedules, :deleted_at
  end
end
