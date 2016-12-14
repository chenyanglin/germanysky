class AccountLevelsController < ApplicationController
before_filter :current_user
before_action :set_accountlevel, only: [:edit, :update, :destroy]
  def index


        @accountlevels = AccountLevel.all
        @accountlevels = @accountlevels.like(params[:filter]) if params[:filter]
        @accountlevels = @accountlevels.order(updated_at: :desc) if params[:recent]
        @accountlevels_size = @accountlevels.size
        @accountlevels = @accountlevels.page(params[:page]).per(15)
        @accountlevel_infos = false

  end

def new
    @accountlevel = AccountLevel.new
    render :layout => "empty"
  end
  def register
    @accountlevel = AccountLevel.new
    render :layout => "empty"
  end

  def create
    @accountlevel = AccountLevel.new(accountlevel_params)
    if @accountlevel.save
      render :text => "success"
    else
      render :text => "error"
    end
  end

  def edit
    render :layout => "empty"
  end

  def update
    if @accountlevel.update(accountlevel_params)
      render :text => "success"
    else
      render :text => "error"
    end
  end

def destroy
    @accountlevel.destroy

    redirect_to account_levels_path
  end

    def accountlevel_params
    params.require(:account_level).permit(:level_name,:order_price,:score,:discount)
  end

    def set_accountlevel
    @accountlevel = AccountLevel.find(params[:id])
  end
end