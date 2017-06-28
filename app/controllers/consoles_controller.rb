class ConsolesController < ApplicationController
  before_filter :current_user, :only => [:index,:index_old,:index_new,:notice,:aboutus]
  before_filter :setting
	def index
		# @console_user ||= ManagerAccount.find(1)
    @product = Product.includes(:productimages).where(on_store: true).limit(4)
    @product = @product.order("created_at desc")
    @new_products = Product.includes(:productimages).where(on_store: true).limit(8)
    @new_products = @new_products.order("created_at desc")
    @last_products = @new_products[4..8]
    @new_products = @new_products[0..3]
    @hotsale_products = @new_products[0..2]
	end
  def index_new
    # @console_user ||= ManagerAccount.find(1)
    @product = Product.includes(:productimages).where(on_store: true).limit(4)
    @product = @product.order("created_at desc")
    @new_products = Product.includes(:productimages).where(on_store: true).limit(8)
    @new_products = @new_products.order("created_at desc")
    @last_products = @new_products[4..8]
    @new_products = @new_products[0..3]
    @hotsale_products = @new_products[0..2]
  end
  def abc
  end
    def index_old
    # @console_user ||= ManagerAccount.find(1)
    @product = Product.includes(:productimages).where(on_store: true).limit(4)
    @product = @product.order("created_at desc")
    @new_products = Product.includes(:productimages).where(on_store: true).limit(8)
    @new_products = @new_products.order("created_at desc")
    @last_products = @new_products[4..8]
    @new_products = @new_products[0..3]
    @hotsale_products = @new_products[0..2]
  end
  def fblogin
    @account = Account.find_by_account_name(params[:uid])
    if @account != nil
      session[:user_id] = @account.id
      session[:profile_photo] = params[:profile_photo]
      render :text => "login"
    else
      render :text => "register"
    end
  end

  def googlelogin
    @account = Account.find_by_account_name(params[:googleid])
    if @account != nil
      session[:user_id] = @account.id
      # session[:profile_photo] = params[:profile_photo]
      render :text => "login"
    else
      session[:name] = params[:name]
      session[:email] = params[:email]
      session[:googleid] = params[:googleid]
      render :text => "register"
    end
  end

	def login
    if session[:user_id] != nil
         @account = Account.find_by(id: session[:user_id])
        end
        if session[:profile_photo].present?
          session[:profile_photo] = nil
        end
  render :layout => "empty"
	end

	def signin
    # render :layout => "empty"
    name = params[:email]
    @account = Account.find_by_account_name(name)

    if @account && @account.authenticate(params[:password])
      session[:user_id] = @account.id

      if params[:remember_email] == "true"
        cookies[:is_remember] = params[:remember_email]
        cookies[:user_email] = params[:email]
      end

     redirect_to consoles_path
      # end
    else
      redirect_to login_consoles_path
    end
		
	end

  def logout
       if session[:user_id].present?
        session[:user_id] = nil
        end
        if session[:profile_photo].present?
          session[:profile_photo] = nil
        end
    # cookies.delete(:auth_token)
    redirect_to consoles_path
  end
  def aboutus
  end
  def notice
  end
  def templateindex
    @new_products = Product.includes(:productimages).where(on_store: true).limit(4)
    @new_products = @new_products.order("created_at desc")
  end
  def testtemplate
  end
  def subscription
    @newsletteremail = NewsletterEmail.new
    @newsletteremail.email = params[:email]
    if @current_user != nil
      @newsletteremail.account_id = @current_user.id
      @newsletteremail.name = @current_user.name
      @newsletteremail.account_name = @current_user.account_name
    end
  if @newsletteremail.save
    render :text => "success"
  else
    render :text => "error"
  end
    
  end
	  def test
Producttype.create!( name: "現貨")
Producttype.create!( name: "預購空運")
Producttype.create!( name: "預購海運")
Account.create!( :account_name => "germanysky", :password => "germanysky" ,:name => "種馬",:sex=>"男",:email => "germanysky@gmail.com",:role =>1 , :account_level_id => "1",:score => 0,:point =>100000)
AccountLevel.create!(level_name: "基本會員",score: 0,order_price: 0,discount: 0)

      redirect_to login_consoles_path

  end
end
