class DeliveriesController < ApplicationController
before_filter :current_user
before_filter :setting
before_action :set_delivery, only: [:edit, :update, :destroy]
  def index


        @deliveries = Delivery.all
        @deliveries = @deliveries.like(params[:filter]) if params[:filter]
        @deliveries = @deliveries.order(updated_at: :desc) if params[:recent]
        @deliveries_size = @deliveries.size
        @deliveries = @deliveries.page(params[:page]).per(15)


  end
    def index_old


        @deliveries = Delivery.all
        @deliveries = @deliveries.like(params[:filter]) if params[:filter]
        @deliveries = @deliveries.order(updated_at: :desc) if params[:recent]
        @deliveries_size = @deliveries.size
        @deliveries = @deliveries.page(params[:page]).per(15)


  end
def new
    @delivery = Delivery.new
    render :layout => false
  end

  def create
    @delivery = Delivery.new(delivery_params)
    if @delivery.save
    	render :text => "success"
	else
		render :text => "error"
	end
  end

  def edit
    render :layout => false
  end

  def update
    if @delivery.update(delivery_params)
      render :text => "success"
    else
      render :text => "error"
    end
  end

def destroy
    @delivery.destroy

    redirect_to deliveries_path
  end


    def delivery_params
    params.require(:delivery).permit(:name, :description,:price)
  end
    def set_delivery
    @delivery = Delivery.find(params[:id])
  end
end