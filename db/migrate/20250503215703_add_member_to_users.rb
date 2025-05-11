class AddMemberToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :member, null: false, foreign_key: true
    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at
  end
end
