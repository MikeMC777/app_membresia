class CreateTeamRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :team_roles do |t|
      t.references :member, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :team_roles, :deleted_at
  end
end
