class UserApi::AuthenticationsController < UserApi::BaseController
  skip_before_action :require_login!
  def sign_in
    @user = User.find_by email: params[:email]

    raise UnauthorizedError, 'Error dengan login atau password' if @user.blank?
    raise UnauthorizedError, 'Error dengan login atau password' unless @user.valid_password? params[:password]

    @user.generate_auth_token
  end
end
