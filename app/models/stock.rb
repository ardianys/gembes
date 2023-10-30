class Stock < ApplicationRecord
  include WalletOwner
  validates_presence_of :name
end
