class ProductsController < ApplicationController
before_filter :current_user
before_action :set_product, only: [:edit, :update, :destroy]
  def index

        @brands = Brand.all
        @type_ones = TypeOne.all
        @products = Product.all.includes(:productimages,:producttype).includes(:type_one).where(on_store: true)
        # binding.pry
        @products = @products.like(params[:filter]) if params[:filter]
        @products = @products.order(updated_at: :desc) if params[:recent]
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
        @products = Product.all.includes(:productimages,:type_one,:producttype)
        @products = @products.like(params[:filter]) if params[:filter]
        @products = @products.order(updated_at: :desc) if params[:recent]
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

def new
    @product = Product.new
    render :layout => "empty"
  end

  def create
    @product = Product.new
    @product.name = params[:product][:name]
    @product.briefdescription = params[:product][:briefdescription]
    @product.type_one_id = params[:product][:type_one_id]
    @product.brand_id = params[:product][:brand_id]
    @product.point = params[:product][:point]
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
      params[:delivery_id].each do |d|
        ProductDeliveryship.create(:product_id => @product.id, :delivery_id => d)
      end
      params[:payment_id].each do |d|
        ProductPaymentship.create(:product_id => @product.id, :payment_id => d)
      end
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
  @brands = Brand.all
  @type_ones = TypeOne.all
  @product = Product.find(params[:id])#.includes(:product_options)
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
    sum = params[:sum]
    if @current_user
    @shoppingcart = Shoppingcart.new
    @shoppingcart.account_id = @current_user.id
    @shoppingcart.product_id = product_id
    @shoppingcart.sum = sum
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

    @shoppingcarts = Shoppingcart.where('account_id = ?',@current_user.id)
    @order_price = 0
    @payments = []
    @deliveries =[]
    begin
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
    rescue
    end
    # render :layout => "empty"
    
  end
  def shoppingcart_plus
    cart= Shoppingcart.find(params[:cart_id])
    if cart.update(sum: cart.sum+1)
      render :text => "success"
    else
      render :text => "error"
    end
    
  end
    def shoppingcart_minus
cart= Shoppingcart.find(params[:cart_id])
     if cart.update(sum: cart.sum-1)
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
    @copy_product = Product.new
    render :text => "success"
  end
  def shopprocess
  end

    def product_params
    params.require(:product).permit(:name, :briefdescription,:price,:surplus,:type_one_id)
  end
  def photo_params
      params.require(:product).permit(:upload)
    end
    def set_product
    @product = Product.find(params[:id])
  end
end