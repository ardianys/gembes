class Team < ApplicationRecord
  has_many :members, dependent: :destroy
end
