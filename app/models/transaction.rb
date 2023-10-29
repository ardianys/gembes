class Transaction < ApplicationRecord

  belongs_to :from_wallet, class_name: 'Wallet', optional: true
  belongs_to :to_wallet, class_name: 'Wallet'

  validates :from_wallet_id, presence: true
  validates :to_wallet_id, presence: true
  validates :from_who_id, presence: true
  validates :to_who_id, presence: true
  validates :from_who_class, presence: true
  validates :to_who_class, presence: true
  validates :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :from_who_class, inclusion: { in: %w(User Team Stock) }
  validates :to_who_class, inclusion: { in: %w(User Team Stock) }

  validate :validate_balance, if: -> { from_wallet && to_wallet }
  def validate_balance
    from_wallet_balance = from_wallet.balance
    message = "Maximum amount available is #{from_wallet_balance}"
    errors.add :amount, message if from_wallet_balance - self.amount < 0
  end
end
