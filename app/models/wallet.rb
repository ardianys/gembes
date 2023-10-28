class Wallet < ApplicationRecord
  has_many :credits, class_name: 'Transaction', foreign_key: 'to_wallet_id', dependent: :nullify
  has_many :debits, class_name: 'Transaction', foreign_key: 'from_wallet_id', dependent: :nullify

  def balance
    credits_amount - debits_amount
  end

  def credits_amount
    credits.sum(:amount)
  end

  def debits_amount
    debits.sum(:amount)
  end
end
