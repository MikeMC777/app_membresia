class TeamRole < ApplicationRecord
  belongs_to :member
  belongs_to :team
  belongs_to :role
end
