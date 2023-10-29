class UserApi::WalletsController < UserApi::BaseController
  before_action :set_wallet, only: [:show, :update, :destroy]

  def index
    @wallets = Wallet
      .order(id: :desc).paginate(:page => params[:page])
  end

  def show
  end

  def create
    @wallet = Wallet.new(wallet_params)
    owner = @wallet.who_class.constantize.find @wallet.who_id
    @wallet.owner = owner

    if @wallet.save
      render :show, status: :created, location: [:user_api, @wallet]
    else
      render json: @wallet.errors, status: :unprocessable_entity
    end
  end

  def update
    if @wallet.update(wallet_params)
      render :show, status: :ok, location: [:user_api, @wallet]
    else
      render json: @wallet.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @wallet.destroy
    head :no_content
  end

  private
    def set_wallet
      @wallet = Wallet.find(params[:id])
    end

    def wallet_params
      params.permit(
        :who_id,
        :who_class,
        :code,
        :name,
      )
    end
end
