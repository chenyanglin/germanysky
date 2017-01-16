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
        @orders = @orders.order(updated_at: :desc)
        @orders_size = @orders.size
        @orders = @orders.page(params[:page]).per(15)
    else
      @orders = @current_user.orders
        @orders = @orders.like(params[:filter]) if params[:filter]
        @orders = @orders.order(updated_at: :desc)
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
    @get_point = 0
    @shoppingcarts.each do |s|
      @get_point += s.get_point
      @order_price += s.product.product_options.find(s.option_id).price*s.sum
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
    @order.ordernumber = Time.now.strftime("%Y%m%d")
    @order.use_point = params[:order][:usepoint]
    lastpoint = @current_user.point - params[:order][:usepoint].to_i
    @current_user.update(point: lastpoint)
    if params[:order][:cash_on_delivery].present?
      @order.cash_on_delivery = true
    else
      @order.cash_on_delivery = false
    end
    if @order.save
      ordernumber = Time.now.strftime("%Y%m%d")+@order.id.to_s.rjust(4, '0')
      @order.update(ordernumber: ordernumber)
      get_point = 0
      @shoppingcarts = Shoppingcart.where('account_id = ?',@current_user.id.to_s)
      @shoppingcarts.each do |s|
      get_point += s.get_point
      @order_product = OrderProduct.new
      @order_product.order_id = @order.id
      @order_product.product_id = s.product.id
      @order_product.product_name = s.product.name
      @order_product.option_name = s.product.product_options.find(s.option_id).option1
      @order_product.single_price = s.product.product_options.find(s.option_id).price
      @order_product.sum_price = s.product.product_options.find(s.option_id).price*s.sum
      @order_product.sum = s.sum
      @order_product.save
      @product=ProductOption.find(s.option_id)
      @product.update(surplus: @product.surplus-s.sum)
      if @product.surplus <= 0
        content = "商品「 "+@product.product.name+"」之規格「"+@product.option1+"」已無庫存，請評估是否補貨上架。"
        NewsMailer.system_email("商品缺貨通知",content).deliver_now!
      end
      s.destroy
      end
      NewsMailer.normal_email("訂單成立通知","感謝您訂購GermanySky商品，您已於"+@order.created_at.to_s+"訂購完成。訂單編號為"+@order.ordernumber.to_s+"，總金額為"+@order.total_price.to_s+"。您可以登入網站查看訂單詳細資訊與進行訂單程序。",@current_user.id).deliver_now!
      content = "使用者 "+@current_user.name.to_s+" 剛建立一筆訂單，詳細資訊請登入後台查詢。"
      NewsMailer.system_email("訂單成立通知",content).deliver_now!
      @order.update(get_point: get_point)
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
    @messages = @order.order_messages
    @message = OrderMessage.new
    render :layout => false
  end

  def usercheckpay
    render :layout => false
  end
  def usercheckpay_update
    if @order.update(pay_status: 2, lastfivepay: params[:lastfivepay],paidprice: params[:paidprice])
      content_to_user = "感謝您已將訂單編號"+@order.ordernumber.to_s+"之訂單狀態轉變為已付款，我們會儘速確認並處理商品事宜。您可以登入網站查看訂單詳細資訊，謝謝。"
      NewsMailer.normal_email("訂單狀態通知（未付款->已付款未確認）",content_to_user,@current_user.id).deliver_now!
      content = "使用者 "+@current_user.name.to_s+"已將訂單編號"+@order.ordernumber.to_s+"之訂單狀態改變為已付款，請逕行確認"
      NewsMailer.system_email("訂單狀態通知（未付款->已付款未確認）",content).deliver_now!
      redirect_to orders_path
    else
      render :text => "error"
    end
  end
    def confirmpay
    if @order.update(pay_status: 3)
      content_to_user = "訂單編號"+@order.ordernumber.to_s+"之訂單狀態已轉變為確認匯款，我們已經確認您的匯款並會儘速處理商品事宜。您可以登入網站查看訂單詳細資訊，謝謝。"
      NewsMailer.normal_email("訂單狀態通知（已付款未確認->已確認付款）",content_to_user,@order.account_id).deliver_now!
      content = "您已將使用者 "+@current_user.name.to_s+"之訂單編號"+@order.ordernumber.to_s+"之訂單狀態改變為已確認付款。"
      NewsMailer.system_email("訂單狀態通知（已付款未確認->已確認付款）",content).deliver_now!
      redirect_to orders_path
    else
      render :text => "error"
    end
  end
  def confirmdelivery
    if @order.update(delivery_status: 2)

      content_to_user = "訂單編號"+@order.ordernumber.to_s+"之訂單狀態已轉變為已出貨，請您取貨後再上系統確認，您可以登入網站查看訂單詳細資訊，謝謝。"
      NewsMailer.normal_email("訂單狀態通知（未出貨->已出貨）",content_to_user,@order.account_id).deliver_now!
      content = "您已將使用者 "+@current_user.name.to_s+"之訂單編號"+@order.ordernumber.to_s+"之訂單狀態改變為已出貨。"
      NewsMailer.system_email("訂單狀態通知（未出貨->已出貨）",content).deliver_now!
      
      redirect_to orders_path
    else
      render :text => "error"
    end
  end
  
  def takeproduct
    if @order.update(delivery_status: 3)
      content_to_user = "感謝您已將訂單編號"+@order.ordernumber.to_s+"之訂單狀態轉變為已取貨，希望您滿意我們的商品，有任何疑問都可以在留言板聯繫我們。您可以登入網站查看訂單詳細資訊，謝謝。"
      NewsMailer.normal_email("訂單狀態通知（已出貨->已取貨）",content_to_user,@current_user.id).deliver_now!
      content = "使用者 "+@current_user.name.to_s+"已將訂單編號"+@order.ordernumber.to_s+"之訂單狀態改變為已取貨，請逕行確認"
      NewsMailer.system_email("訂單狀態通知（已出貨->已取貨）",content).deliver_now!
      redirect_to orders_path
    else
      render :text => "error"
    end
  end
  def orderdone
    if @order.update(delivery_status: 5,pay_status: 6)
      new_score = @current_user.score.to_i+@order.total_price.to_i-@order.delivery_price.to_i-@order.payment_price.to_i
      @current_user.update(score: new_score)
      @level = AccountLevel.where("score >= ?",new_score).order(:score).last
      if @current_user.account_level_id.to_s == @level.id.to_s
      else
        @current_user.update(account_level_id: @level.id)
        NewsMailer.normal_email("會員等級更改通知","您的會員等級更改為"+@level.level_name.to_s,@current_user.id).deliver_now!
      end
      @current_user.update(point: @current_user.point+@order.get_point)
      content_to_user = "訂單編號"+@order.ordernumber.to_s+"之訂單已完成所有付款與寄送事宜，希望您滿意我們的商品，有任何疑問都可以在留言板聯繫我們。此筆訂單將封存於系統中，謝謝。"
      NewsMailer.normal_email("訂單狀態通知（訂單完成）",content_to_user,@order.account_id).deliver_now!
      content = "您已將使用者 "+@current_user.name.to_s+"之訂單編號"+@order.ordernumber.to_s+"之訂單狀態改變為完成訂單，訂單資料將封存於系統中，謝謝。"
      NewsMailer.system_email("訂單狀態通知（訂單完成）",content).deliver_now!
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