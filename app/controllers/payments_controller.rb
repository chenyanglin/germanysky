class PaymentsController < ApplicationController
before_filter :current_user
before_action :set_payment, only: [:edit, :update, :destroy]
  def index
        @payments = Payment.all
        @payments = @payments.like(params[:filter]) if params[:filter]
        @payments = @payments.order(updated_at: :desc) if params[:recent]
        @payments_size = @payments.size
        @payments = @payments.page(params[:page]).per(15)
  end
def new
    @payment = Payment.new
    render :layout => false
  end

  def create
    @payment = Payment.new(payment_params)
    if @payment.save
    	render :text => "success"
	else
		render :text => "error"
	end
  end

  def edit
    render :layout => false
  end

  def update
    if @payment.update(payment_params)
      render :text => "success"
    else
      render :text => "error"
    end
  end

def destroy
    @payment.destroy

    redirect_to payments_path
  end


    def payment_params
    params.require(:payment).permit(:name, :description,:dayline,:price)
  end
    def set_payment
    @payment = Payment.find(params[:id])
  end
end