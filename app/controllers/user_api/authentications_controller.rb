class UserApi::AuthenticationsController < UserApi::BaseController
  skip_before_action :require_login!
  def sign_in
    @user = User.find_by email: params[:email]

    msg = 'Wrong email or password'
    raise UnauthorizedError, msg if @user.blank?
    raise UnauthorizedError, msg unless @user.valid_password? params[:password]

    @user.generate_auth_token
  end
end
