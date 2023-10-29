require 'rails_helper'

RSpec.describe Member, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:team_id) }
    it { should validate_presence_of(:user_id) }
  end
end
