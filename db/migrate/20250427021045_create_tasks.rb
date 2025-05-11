class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.references :monthly_schedule, foreign_key: true
      t.date :start_date
      t.date :due_date
      t.references :created_by, null: false, foreign_key: { to_table: :members }
      t.references :assigned_to, foreign_key: { to_table: :members }
      t.integer :status, default: 0  # Si usas un enum para el estado
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :tasks, :deleted_at
  end
end
