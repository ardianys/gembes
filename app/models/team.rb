class Team < ApplicationRecord
  has_many :members, dependent: :destroy
  has_many :wallets, -> { where('who_class = ?', 'Team') }, class_name: 'Wallet', foreign_key: 'who_id', dependent: :nullify

  validates_presence_of :name
end
