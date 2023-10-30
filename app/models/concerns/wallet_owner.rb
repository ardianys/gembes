module WalletOwner
  extend ActiveSupport::Concern

  included do
    has_many :wallets, -> { where('who_class = ?', self.base_class.to_s) },
        as: :owner,
        class_name: 'Wallet',
        foreign_key: 'who_id',
        foreign_type: 'who_class',
        dependent: :nullify if ['User', 'Team', 'Stock'].include?(self.base_class.to_s)
  end
end