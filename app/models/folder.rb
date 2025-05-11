class Folder < ApplicationRecord
  belongs_to :team
  belongs_to :parent_folder
end
