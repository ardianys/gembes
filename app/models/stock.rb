class Stock < ApplicationRecord
  has_many :wallets, -> { where('who_class = ?', 'Stock') }, as: :owner, class_name: 'Wallet', foreign_key: 'who_id', foreign_type: 'who_class', dependent: :nullify

  validates_presence_of :name
end
