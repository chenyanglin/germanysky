class SpecialoffersController < ApplicationController
before_filter :current_user
before_filter :setting
before_action :set_specialoffer, only: [:edit, :update, :destroy]
  def index


        @specialoffers = Specialoffer.all
        @specialoffers = @specialoffers.like(params[:filter]) if params[:filter]
        @specialoffers = @specialoffers.order(updated_at: :desc) if params[:recent]
        @specialoffers_size = @specialoffers.size
        @specialoffers = @specialoffers.page(params[:page]).per(15)
        @specialoffer_infos = false
        @product_type = TypeOne.all
        @newsboard_info = false

  end
def index_old
  
        @specialoffers = Specialoffer.all
        @specialoffers = @specialoffers.like(params[:filter]) if params[:filter]
        @specialoffers = @specialoffers.order(updated_at: :desc) if params[:recent]
        @specialoffers_size = @specialoffers.size
        @specialoffers = @specialoffers.page(params[:page]).per(15)
        @specialoffer_infos = false
        @product_type = TypeOne.all
        @newsboard_info = false
end
  def new
    @specialoffer = Specialoffer.new
    render :layout => "empty"
  end


  def create
    if params[:offertype] == "1"
      @specialoffer = Specialoffer.new(specialoffer_params)
      @specialoffer.offertype = 1
      @specialoffer.status = true
      @specialoffer.saleprice = params[:specialoffer][:saleprice]
    elsif params[:offertype] == "2"
      @specialoffer = Specialoffer.new(specialoffer_params)
      @specialoffer.offertype = 2
      @specialoffer.status = true
      @specialoffer.discount = params[:specialoffer][:discount]
    end

    if @specialoffer.save
      render :text => "success"
    else
      render :text => "error"
    end
  end

  def edit
    if @specialoffer.offertype == "1"
      @offertype = 1
    elsif @specialoffer.offertype =="2"
      @offertype = 2
    end
    # binding.pry
    render :layout => "empty"
  end

  def update
    if @specialoffer.update(specialoffer_params)

      if @specialoffer.offertype == "1"
        @specialoffer.update(saleprice: params[:specialoffer][:saleprice])
    elsif @specialoffer.offertype == "2"
      @specialoffer.update(saleprice: params[:specialoffer][:discount])
    end
      render :text => "success"
    else
      render :text => "error"
    end
  end
def show
  @specialoffer = Specialoffer.find(params[:id])#.includes(:products,:product_options)
  @products = @specialoffer.product_options
  @product_info = false
end
def destroy
    @specialoffer.destroy

    redirect_to specialoffers_path
  end
    def add_to_salecart
    @salecart = Salecart.new
    @salecart.account_id = @current_user.id
    @salecart.specialoffer_id = params[:specialoffer_id]
    if @salecart.save
      if params[:product].present?
        params[:product].each do |p|
          @product = SalecartProduct.new
          @product.option_id = p[1][:id]
          @product.salecart_id = @salecart.id
          @product.sum = p[1][:sum]
          @product.sellprice = p[1][:saleprice]
          option = ProductOption.find(p[1][:id])
          @product.originalprice = option.price
          @product.product_id = option.product.id
          @product.save
        end
      end
      redirect_to shoppingcart_products_path
    else
      redirect_to shoppingcart_products_path
    end
    
  end
def select_product
  @offer_id = params[:id]
  @products= Product.all.includes(:product_options)
  if params[:type].present?
  @products = Product.where("type_one_id = ?",params[:type]).includes(:product_options)
  end
  render :layout => "empty"
end
def insertproduct
  Specialoffer.find(params[:offer_id]).product_specialofferships.destroy_all
  params[:selected_data_array].each do |p|
    param = p.split(",")
    ps = ProductSpecialoffership.new
    ps.specialoffer_id = params[:offer_id]
    ps.product_id = param[0]
    ps.product_option_id = param[1]
    ps.save

  end
  render :text => "success"
  end
    def specialoffer_params
    params.require(:specialoffer).permit(:name,:productcount)
  end

    def set_specialoffer
    @specialoffer = Specialoffer.find(params[:id])
  end
end