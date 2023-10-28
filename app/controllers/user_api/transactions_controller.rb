class UserApi::TransactionsController < UserApi::BaseController
  before_action :set_transaction, only: [:show, :update, :destroy]

  def index
    @transactions = Transaction
      .order(id: :desc).paginate(:page => params[:page])
  end

  def show
  end

  def create
    @transaction = Transaction.new(transaction_params)

    msg = 'Source wallet not valid'
    return render json: msg, status: :unprocessable_entity unless @transaction.from_wallet

    msg = 'Target wallet not valid'
    return render json: msg, status: :unprocessable_entity unless @transaction.to_wallet

    if @transaction.save
      render :show, status: :created, location: [:user_api, @transaction]
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def update
    if @transaction.update(transaction_params)
      render :show, status: :ok, location: [:user_api, @transaction]
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @transaction.destroy
    head :no_content
  end

  private
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def transaction_params
      params.permit(
        :from_wallet_id,
        :to_wallet_id,
        :from_who_id,
        :to_who_id,
        :from_who_class,
        :to_who_class,
        :amount,
      )
    end
end
