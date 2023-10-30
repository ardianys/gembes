class UserApi::UsersController < UserApi::BaseController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User
      .order(id: :desc).paginate(:page => params[:page])
  end

  def show
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render :show, status: :created, location: [:user_api, @user]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render :show, status: :ok, location: [:user_api, @user]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(
        :auth_token,
        :email,
        :name,
        :password,
      )
    end
end
