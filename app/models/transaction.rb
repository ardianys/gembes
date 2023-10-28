class Transaction < ApplicationRecord

  belongs_to :from_wallet, class_name: 'Wallet', optional: true
  belongs_to :to_wallet, class_name: 'Wallet'

  # but how to handle money chicken egg problem ?
  # validates :from_wallet
  validates :to_wallet, presence: true
  validates :from_who_id, presence: true, if: -> { from_wallet.present? }
  validates :to_who_id, presence: true
  validates :from_who_class, presence: true, if: -> { from_wallet.present? }
  validates :to_who_class, presence: true
  validates :amount, numericality: { greater_than: 0 }

  validate :validate_balance, if: -> { from_wallet.present? && to_wallet.present? }
  def validate_balance
    from_wallet_balance = from_wallet.balance
    message = "Maximum amount available is #{from_wallet_balance}"
    errors.add :amount, message if from_wallet_balance - self.amount < 0
  end
end
