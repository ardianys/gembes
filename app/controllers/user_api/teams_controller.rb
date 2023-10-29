class UserApi::TeamsController < UserApi::BaseController
  before_action :set_team, only: [:show, :update, :destroy]

  def index
    @teams = Team
      .order(id: :desc).paginate(:page => params[:page])
  end

  def show
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      render :show, status: :created, location: [:user_api, @team]
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  def update
    if @team.update(team_params)
      render :show, status: :ok, location: [:user_api, @team]
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @team.destroy
    head :no_content
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.permit(
        :name,
      )
    end
end
