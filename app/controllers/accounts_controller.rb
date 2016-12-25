class AccountsController < ApplicationController
before_filter :current_user
before_action :set_account, only: [:edit, :update,:show, :destroy,:console_edit]
  def index


        @accounts = Account.all
        @accounts = @accounts.like(params[:filter]) if params[:filter]
        @accounts = @accounts.order(updated_at: :desc) if params[:recent]
        @accounts_size = @accounts.size
        @accounts = @accounts.page(params[:page]).per(15)
        @account_info = false

  end

def new
    @account = Account.new
    render :layout => "empty"
  end
  def register
    @account = Account.new

  end

  def create
    @account = Account.new(account_params)
    @account.account_level_id = "1"
    @account.role = "2"
    if @account.save
      render :text => "success"
    else
      render :text => "error"
    end
  end

  def edit
    
  end
  def console_edit
    render :layout => "empty"
  end
  def show
    @messages = @account.messages
    render :layout => "empty"
  end
  def update
    if @account.update(account_params)
      render :text => "success"
    else
      render :text => "error"
    end
  end

def destroy
    @account.destroy

    redirect_to accounts_path
  end
  # def create_with_fb
  #   user = Account.from_omniauth(env["omniauth.auth"])
  #   session[:user_id] = user.id
  #   redirect_to home_path
  # end
  def failure
    super
  end

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user , :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  
def create_with_fb
  auth_hash = request.env['omniauth.auth']

  @authorization = Account.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])

  if @authorization
    render :text => "Welcome back #{@authorization.user.name}! You have already signed up."
  else
    user = Account.new :name => auth_hash["info"]["name"], :email => auth_hash["info"]["email"]
    user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    user.save
    puts(user.name)
    render :text => "Hi #{user.name}! You've signed up."
  end
end
    def account_params
    params.require(:account).permit(:account_name,:name,:password,:password_confirmation)
  end

    def set_account
    @account = Account.find(params[:id])
  end
end