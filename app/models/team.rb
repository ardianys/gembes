class Team < ApplicationRecord
  has_many :members, dependent: :destroy
  has_many :wallets, -> { where('who_class = ?', 'Team') }, as: :owner, class_name: 'Wallet', foreign_key: 'who_id', foreign_type: 'who_class', dependent: :nullify

  validates_presence_of :name
end
