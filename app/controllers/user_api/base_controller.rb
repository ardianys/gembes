class UserApi::BaseController < ActionController::Base
  before_action :require_login!
  helper_method :person_signed_in?, :current_user

  def append_info_to_payload(payload)
    super
    payload[:user_id] = current_user.try(:id) if defined? current_user
  end

  def user_signed_in?
    current_person.present?
  end

  def require_login!
    return true if authenticate_token

    render json: { msg: 'Access denied' }, status: :unauthorized
  end

  def current_user
    @_current_user ||= authenticate_token
  end

  rescue_from ActiveRecord::RecordNotFound do
    render json: { msg: 'Not found' }, status: :not_found
  end

  private

  def not_authorized
    render json: { msg: 'You are not authorized to perform this action.' }, status: :unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, _options|
      User.find_by(auth_token: token)
    end
  end
end
