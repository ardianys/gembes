module WalletOwner
  extend ActiveSupport::Concern

  included do
    has_many :wallets,
        as: :owner,
        class_name: 'Wallet',
        foreign_key: 'who_id',
        foreign_type: 'who_class',
        dependent: :nullify
  end
end