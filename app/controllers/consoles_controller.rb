class ConsolesController < ApplicationController
  before_filter :current_user, :only => [:index]
	def index
		# @console_user ||= ManagerAccount.find(1)
    @product = Product.includes(:productimages).where(on_store: true).limit(4)
    @product = @product.order("created_at desc")
    @newsboards = Newsboard.limit(5).order('id desc')
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
  def templateindex

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
    @account = ManagerAccount.new

    @account.name = "germanysky"
    @account.password_digest = "germanysky"
    @account.email = "chenyang1205@gmail.com"

    if @account.save
      redirect_to login_consoles_path
    else
      redirect_to login_consoles_path
    end
  end
end
