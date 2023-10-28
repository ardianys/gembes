class UserApi::MembersController < UserApi::BaseController
  before_action :set_member, only: [:show, :update, :destroy]

  def index
    @members = Member
      .where(user: current_user)
      .order(id: :desc).paginate(:page => params[:page])
  end

  def show
  end

  def create
    @member = Member.new(member_params)
    @member.user = current_user

    if @member.save
      render :show, status: :created, location: [:user_api, @member]
    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  def update
    if @member.update(member_params)
      render :show, status: :ok, location: [:user_api, @member]
    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @member.destroy
    head :no_content
  end

  private
    def set_member
      @member = Member.find(params[:id])
    end

    def member_params
      params.permit(
        :user_id,
        :team_id,
      )
    end
end
