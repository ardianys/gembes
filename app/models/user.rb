class User < ApplicationRecord
  # include WalletOwner
  has_many :members, dependent: :destroy
  has_many :wallets, -> { where('who_class = ?', 'User') },
      as: :owner,
      class_name: 'Wallet',
      foreign_key: 'who_id',
      foreign_type: 'who_class',
      dependent: :nullify

  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :password
  validates_presence_of :auth_token

  def generate_auth_token
    self.update auth_token: Digest::SHA1.hexdigest(self.email + self.id.to_s)
  end

  def set_password value
    self.update password: Digest::SHA1.hexdigest(value)
  end

  def valid_password? value
    self.password == Digest::SHA1.hexdigest(value)
  end
end
