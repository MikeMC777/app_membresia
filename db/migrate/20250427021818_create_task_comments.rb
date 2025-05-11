class CreateTaskComments < ActiveRecord::Migration[7.1]
  def change
    create_table :task_comments do |t|
      t.text :body
      t.references :task, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :task_comments, :deleted_at
  end
end
