class Wallet < ApplicationRecord
  has_many :credits, class_name: 'Transaction', foreign_key: 'to_wallet_id', dependent: :nullify
  has_many :debits, class_name: 'Transaction', foreign_key: 'from_wallet_id', dependent: :nullify
  belongs_to :owner, polymorphic: true, foreign_key: 'who_id', foreign_type: 'who_class', optional: true

  validates :who_id, presence: true
  validates :who_class, presence: true
  validates :code, presence: true
  validates :name, presence: true
  validates :who_class, inclusion: { in: %w(User Team Stock) }

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
