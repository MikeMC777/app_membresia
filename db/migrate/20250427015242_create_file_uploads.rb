class CreateFileUploads < ActiveRecord::Migration[7.1]
  def change
    create_table :file_uploads do |t|
      t.string :name
      t.integer :size
      t.string :url
      t.references :folder, null: false, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :file_uploads, :deleted_at
  end
end
