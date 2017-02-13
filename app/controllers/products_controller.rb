class ProductsController < ApplicationController
before_filter :current_user
before_filter :setting
before_action :set_product, only: [:edit, :update, :destroy]
  def index
        @products = Product.all.includes(:productimages,:producttype).includes(:type_one).where(on_store: true)
        # binding.pry
        @products = @products.like(params[:filter]) if params[:filter]
        @products = @products.order(updated_at: :desc)
        @products_size = @products.size
        @products = @products.page(params[:page]).per(15)
        if params[:brand].present?
          @products = @products.where("brand_id = ?",params[:brand])
          @products_size = @products.size
          @brand = Brand.find(params[:brand])
        end
        if params[:type].present?
          @products = @products.where("type_one_id = ?",params[:type])
          @products_size = @products.size
          @type = TypeOne.find(params[:type])
        end
        @product_info = false

  end
    def products_template

        @brands = Brand.all
        @type_ones = TypeOne.all
        @products = Product.all.includes(:productimages,:producttype).includes(:type_one).where(on_store: true)
        # binding.pry
        @products = @products.like(params[:filter]) if params[:filter]
        @products = @products.order(updated_at: :desc)
        @products_size = @products.size
        @products = @products.page(params[:page]).per(15)
        if params[:brand].present?
          @products = @products.where("brand_id = ?",params[:brand])
          @products_size = @products.size
          @brand = Brand.find(params[:brand])
        end
        if params[:type].present?
          @products = @products.where("type_one_id = ?",params[:type])
          @products_size = @products.size
          @type = TypeOne.find(params[:type])
        end
        @product_info = false

  end
    def console_index

        @brands = Brand.all
        @type_ones = TypeOne.all
        @products = Product.all.includes(:productimages,:type_one,:producttype,:product_options)
        @products = @products.like(params[:filter]) if params[:filter]
        @products = @products.order(updated_at: :desc)
        @products_size = @products.size
        @products = @products.page(params[:page]).per(15)

        if params[:brand].present?
          @products = @products.where("brand_id = ?",params[:brand])
          @products_size = @products.size
          @brand = Brand.find(params[:brand])
        end
        if params[:type].present?
          @products = @products.where("type_one_id = ?",params[:type])
          @products_size = @products.size
          @type = TypeOne.find(params[:type])
        end
  end
  def outofstock
        @brands = Brand.all
        @type_ones = TypeOne.all
        if params[:less].present?
        @i = params[:less].to_i
        @products = ProductOption.where("surplus <= ?" , @i ).includes(:product_registers,:product => [:productimages,:type_one])
        else
        @products = ProductOption.where("surplus = ?" , 0 ).includes(:product_registers,:product => [:productimages,:type_one])
        end
        @products = @products.like(params[:filter]) if params[:filter]
        @products = @products.order(updated_at: :desc)
        @products_size = @products.size
        @products = @products.page(params[:page]).per(15)
        @registerlists = ProductRegister.all.includes(:account,:product_option)
        @registerlists_size = @registerlists.size

  end

def new
    @product = Product.new
    render :layout => "empty"
  end

  def create
    @product = Product.new(product_params)
    # params.require(:product).permit(:name, :briefdescription,:type_one_id,:brand_id,:point,delivery_ids:[])

    if params[:product][:type_two_id] != ''
      @product.type_two_id = params[:product][:type_two_id]
    end
    if params[:product][:type_three_id] != ''
      @product.type_three_id = params[:product][:type_three_id]
    end
    # @product.price = params[:product][:price]
    # @product.surplus = params[:product][:surplus]
    @product.producttype_id = params[:product][:producttype]
    if params[:on_store] != nil && params[:on_store] == "on"
      @product.on_store = 1
    else
      @product.on_store = false
    end
    if params[:on_buy] != nil && params[:on_buy] == "on"
      @product.available = 1
    else

      @product.available = 0

    end
    @product.content = params[:content]

    if @product.save
      if params[:productstyle] == "option"
        params[:product][:options].each do |a|
          @option = ProductOption.new
          @option.product_id = @product.id
          i = 1
          a[1].each do |b|
            if i == 1
              @option.option1 = b[1]
            end
            if i == 2
              @option.price = b[1]
            end
            if i == 3
              @option.surplus = b[1]
            end
            i += 1
          end
        @option.save
        end
      elsif params[:productstyle] == "normal"
        @option = ProductOption.new
        @option.product_id = @product.id
        @option.option1 = params[:product][:name]
        @option.price = params[:product][:price]
        @option.surplus = params[:product][:surplus]
        @option.save
      else
        render :text => "error"
      end

      params[:product][:files].each do |a|
        @photo = Productimage.new#(:upload => a[1])
        @photo.product_id = @product.id
        @photo.save
        #@photo.update(:phourl => "products/uploads/"+@photo.id.to_s+"/"+@photo.upload_file_name.to_s )
        @photo.update(:phourl =>"100px.png")
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
    if @product.update(product_params)
      render :text => "success"
    else
      render :text => "error"
    end
  end
def show
  @product = Product.find(params[:id])#.includes(:product_options)
  @messages = @product.product_messages
  @message = ProductMessage.new
  @new_products = Product.includes(:productimages).where(on_store: true).limit(3)
    @new_products = @new_products.order("created_at desc")
  if @product.on_store == false
    redirect_to "/"
  end
end
def destroy
    @product.destroy

    redirect_to products_path
  end
  def add_to_shoppingcart
    product_id = params[:product_id]
    option_id = params[:option_id]
    @product = Product.find(product_id)
    sum = params[:sum]
    if @current_user
    @shoppingcart = Shoppingcart.new
    @shoppingcart.account_id = @current_user.id
    @shoppingcart.product_id = product_id
    @shoppingcart.sum = sum
    @shoppingcart.get_point = @product.point*sum.to_i
    @shoppingcart.option_id = option_id
    begin @shoppingcart.save
      render :text => "success"
    rescue
      render :text => "購物車已存在此商品，欲修改數量請至購物車"
    end
    else
      render :text => "請先登入"
    end
  end

  def shoppingcart
    @shoppingcarts = Shoppingcart.where('account_id = ?',@current_user.id.to_s)
    @order_price = 0
    @payments = []
    @deliveries =[]
    begin
    @shoppingcarts.each do |s|
      @order_price += s.product_option.price*s.sum
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
    rescue
    end
    if @current_user.salecarts.present?
      @salecarts = @current_user.salecarts.includes(:salecart_products)
      @salecarts.each do |cart|
        cart.salecart_products.each do |s|
          @order_price += s.sellprice*s.sum
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
      end
    end
    # render :layout => "empty"
    
  end
  def shoppingcart_plus
    cart= Shoppingcart.find(params[:cart_id])
    if cart.get_point != 0
      get_point = cart.get_point*(cart.sum+1)/cart.sum
    else
      get_point = cart.product.point
    end
    if cart.update(sum: cart.sum+1,get_point: get_point)
      render :text => "success"
    else
      render :text => "error"
    end
    
  end
    def shoppingcart_minus
cart= Shoppingcart.find(params[:cart_id])
     if cart.update(sum: cart.sum-1,get_point: cart.get_point*(cart.sum-1)/cart.sum)
      render :text => "success"
    else
      render :text => "error"
    end
    
  end
  def shoppingcart_del
    cart = Shoppingcart.find(params[:id])
    if cart.destroy
      render :text => "success"
    else
      render :text => "error"
    end
  end

  def copy
    @product = Product.find(params[:id])
    @copy_product = Product.new(@product.attributes)
    product_deliveryships = @product.product_deliveryships
    product_paymentships = @product.product_paymentships
    productoptions = @product.product_options
    productimages = @product.productimages
    @copy_product.created_at = nil
    @copy_product.updated_at = nil
    @copy_product.id = nil
    if @copy_product.save
      product_deliveryships.each do |p|
        product_delivery_copy = ProductDeliveryship.new(p.attributes)
        product_delivery_copy.product_id = @copy_product.id
        product_delivery_copy.id = nil
        product_delivery_copy.created_at = nil
        product_delivery_copy.updated_at = nil
        product_delivery_copy.save
      end
      product_paymentships.each do |p|
        product_paymentship_copy = ProductPaymentship.new(p.attributes)
        product_paymentship_copy.product_id = @copy_product.id
        product_paymentship_copy.id = nil
        product_paymentship_copy.created_at = nil
        product_paymentship_copy.updated_at = nil
        product_paymentship_copy.save
      end
      productoptions.each do |p|
        product_option_copy = ProductOption.new(p.attributes)
        product_option_copy.product_id = @copy_product.id
        product_option_copy.id = nil
        product_option_copy.created_at = nil
        product_option_copy.updated_at = nil
        product_option_copy.save
      end
      productimages.each do |p|
        product_image_copy = Productimage.new(p.attributes)
        product_image_copy.product_id = @copy_product.id
        product_image_copy.id = nil
        product_image_copy.created_at = nil
        product_image_copy.updated_at = nil
        product_image_copy.save
      end
    render :text => "success"
    else
      render :text => "error"
    end
  end
  
  def shopprocess
  end
  def register
    @register  = ProductRegister.new
    @product_id = params[:product_id]
    @product_option_id = params[:product_option_id]
    render :layout => false
    
  end
  def product_register
    @register = ProductRegister.new(register_params)
    @register.email = @current_user.email
    @register.account_id = @current_user.id
    @register.account_name = @current_user.name
    if params[:sendemail] == "on"
      @register.sendemail = true
    else
      @register.sendemail = false
    end
    if @register.save
      redirect_to product_path(params[:product_register][:product_id])
    else
      render :text => "error"
    end
  end
  def del_register
    @register = ProductRegister.find(params[:id])
    if @register.destroy
      render :text =>"success"
    else
      render :text => "error"
    end
  end
  def register_params
    params.require(:product_register).permit(:product_id,:product_option_id,:quantity)
  end
  def product_params
    params.require(:product).permit(:name, :briefdescription,:point,:type_one_id,:brand_id,delivery_ids:[],payment_ids:[])
  end
  def photo_params
      params.require(:product).permit(:upload)
    end
    def set_product
    @product = Product.find(params[:id])
  end
end