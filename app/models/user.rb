class User < ApplicationRecord
  has_many :members, dependent: :destroy
  validates_presence_of :name

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
