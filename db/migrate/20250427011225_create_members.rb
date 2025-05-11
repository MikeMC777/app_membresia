class CreateMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :second_name
      t.string :first_surname
      t.string :second_surname
      t.string :email
      t.string :phone
      t.integer :status
      t.date :birth_date
      t.date :baptism_date
      t.integer :marital_status
      t.integer :gender
      t.date :wedding_date
      t.date :membership_date
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :members, :deleted_at
  end
end
