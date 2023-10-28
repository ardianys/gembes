class Stock < ApplicationRecord
  has_many :wallets, -> { where('who_class = ?', 'Stock') }, class_name: 'Wallet', foreign_key: 'who_id', dependent: :nullify

  validates_presence_of :name
end
