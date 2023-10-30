class Team < ApplicationRecord
  include WalletOwner
  has_many :members, dependent: :destroy
  validates_presence_of :name
end
