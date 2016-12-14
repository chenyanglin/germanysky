class ConsolesController < ApplicationController
  before_filter :current_user, :only => [:index]
	def index
		# @console_user ||= ManagerAccount.find(1)
    @product = Product.includes(:productimages).where(on_store: true)
    @product = @product.order("created_at desc")
    @newsboards = Newsboard.limit(5).order('id desc')
    @newsboard = Newsboard.find(1)
	end

	def login
    if session[:user_id] != nil
         @account = Account.find_by(id: session[:user_id])
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
    # cookies.delete(:auth_token)
    redirect_to consoles_path
  end
  def aboutus
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
