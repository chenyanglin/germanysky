class OrdersController < ApplicationController
before_filter :current_user
before_action :set_order, only: [:edit, :update, :destroy,
                                 :usercheckpay_update,:usercheckpay,
                                 :orderdetail,:confirmpay,:confirmdelivery,
                                 :orderdone,:takeproduct]
  def index
    if @current_user.role ==1
    @orders = Order.all
    @orders = @orders.like(params[:filter]) if params[:filter]
        @orders = @orders.order(updated_at: :desc) if params[:recent]
        @orders_size = @orders.size
        @orders = @orders.page(params[:page]).per(15)
    else
      @orders = @current_user.orders
        @orders = @orders.like(params[:filter]) if params[:filter]
        @orders = @orders.order(updated_at: :desc) if params[:recent]
        @orders_size = @orders.size
        @orders = @orders.page(params[:page]).per(15)
    end
  end


def new
    @order = Order.new
    @shoppingcarts = Shoppingcart.where('account_id = ?',@current_user.id.to_s)
    @order_price = 0
    @payments = []
    @deliveries =[]
    @shoppingcarts.each do |s|
      @order_price += s.product.product_options.find_by_option1(s.option_id).price*s.sum
      s.product.payments.each do |p| 
         if @payments.include?(p)
         else
         @payments << p
        end
      end
      s.product.deliveries.each do |d| 
         if @deliveries.include?(d)
         else
         @deliveries << d
        end
      end
    end
    @product_price = @order_price
  end

  def create
    @order = Order.new(order_params)
    @order.pay_status = 1 #未付款
    @order.delivery_status = 1
    payment = params[:order][:payment].split(",")
    @order.payment_id = payment[0]
    @order.payment = Payment.find(payment[0]).name
    @order.payment_price = payment[1]
    delivery = params[:order][:delivery].split(",")
    @order.delivery_id = delivery[0]
    @order.delivery = Delivery.find(delivery[0]).name
    @order.delivery_price = delivery[1]
    @order.account_id = @current_user.id
    @order.account_name = @current_user.name
    
    @order.use_point = params[:order][:usepoint]
    lastpoint = @current_user.point - params[:order][:usepoint].to_i
    @current_user.update(point: lastpoint)
    if params[:order][:cash_on_delivery].present?
      @order.cash_on_delivery = true
    else
      @order.cash_on_delivery = false
    end
    if @order.save
      ordernumber = Time.now.strftime("%Y%m%d")+@order.id.rjust(4, '0')
      @order.update(ordernumber: ordernumber)
      @shoppingcarts = Shoppingcart.where('account_id = ?',@current_user.id.to_s)
      @shoppingcarts.each do |s|
      @order_product = OrderProduct.new
      @order_product.order_id = @order.id
      @order_product.product_id = s.product.id
      @order_product.product_name = s.product.name
      @order_product.option_name = s.product.product_options.find_by_option1(s.option_id).option1
      @order_product.single_price = s.product.product_options.find_by_option1(s.option_id).price
      @order_product.sum_price = s.product.product_options.find_by_option1(s.option_id).price*s.sum
      @order_product.sum = s.sum
      @order_product.save
      s.destroy
    end
      render :text => "success"
    else
      render :text => "error"
    end
  end

  def edit
    render :layout => false
  end
 def update

  end
  def show
  
  end
  def destroy
  @order.destroy
  redirect_to orders_path
  end

  def orderdetail
    render :layout => false
  end

  def usercheckpay
    render :layout => false
  end
  def usercheckpay_update
    if @order.update(pay_status: 2, lastfivepay: params[:lastfivepay],paidprice: params[:paidprice])
      redirect_to orders_path
    else
      render :text => "error"
    end
  end
    def confirmpay
    if @order.update(pay_status: 3)
      redirect_to orders_path
    else
      render :text => "error"
    end
  end
  def confirmdelivery
    if @order.update(delivery_status: 2)
      redirect_to orders_path
    else
      render :text => "error"
    end
  end
  
  def takeproduct
    if @order.update(delivery_status: 3)
      redirect_to orders_path
    else
      render :text => "error"
    end
  end
  def orderdone
    if @order.update(delivery_status: 4,pay_status: 6)
      redirect_to orders_path
    else
      render :text => "error"
    end
  end
  def checkorder
    idlist = params[:data].split(",")
    @orders = Order.where(id: idlist)
    render :layout => false
  end

    def order_params
    params.require(:order).permit(:receiver_name, :receiver_phone,:receiver_address,:total_price,:note)
  end
  def set_order
    @order = Order.find(params[:id])
  end

end