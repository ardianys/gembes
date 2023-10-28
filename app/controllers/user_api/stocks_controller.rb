class UserApi::StocksController < UserApi::BaseController
  before_action :set_stock, only: [:show, :update, :destroy]

  def index
    @stocks = Stock
      .order(id: :desc).paginate(:page => params[:page])
  end

  def show
  end

  def create
    @stock = Stock.new(stock_params)

    if @stock.save
      render :show, status: :created, location: [:user_api, @stock]
    else
      render json: @stock.errors, status: :unprocessable_entity
    end
  end

  def update
    if @stock.update(stock_params)
      render :show, status: :ok, location: [:user_api, @stock]
    else
      render json: @stock.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @stock.destroy
    head :no_content
  end

  private
    def set_stock
      @stock = Stock.find(params[:id])
    end

    def stock_params
      params.permit(
        :name,
      )
    end
end
