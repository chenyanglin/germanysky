class AccountLevelsController < ApplicationController
before_filter :current_user
before_filter :setting
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
    @accounts = Account.all
    if @accountlevel.save
      @accounts.each do |a|
        score = a.score
      @level = AccountLevel.where("score <= ?",score).order(:score).last
        if a.account_level_id.to_s == @level.id.to_s
          else
          a.update(account_level_id: @level.id)
          # binding.pry
          NewsMailer.normal_email("會員等級更改通知","您的會員等級更改為"+@level.level_name.to_s,a.id).deliver_now!
      end
      end
      render :text => "success"
    else
      render :text => "error"
    end
  end

  def edit
    render :layout => "empty"
  end

  def update
    @accounts = Account.all
    if @accountlevel.update(accountlevel_params)
      @accounts.each do |a|
        score = a.score
      @level = AccountLevel.where("score <= ?",score).order(:score).last
        if a.account_level_id.to_s == @level.id.to_s
          else
          a.update(account_level_id: @level.id)
          # binding.pry
          NewsMailer.normal_email("會員等級更改通知","您的會員等級更改為"+@level.level_name.to_s,a.id).deliver_now!
      end
      end
      render :text => "success"
    else
      render :text => "error"
    end
  end

def destroy
   
    @accounts = Account.all
    if @accountlevel.destroy
      @accounts.each do |a|
        score = a.score
      @level = AccountLevel.where("score <= ?",score).order(:score).last
        if a.account_level_id.to_s == @level.id.to_s
          else
          a.update(account_level_id: @level.id)
          # binding.pry
          NewsMailer.normal_email("會員等級更改通知","您的會員等級更改為"+@level.level_name.to_s,a.id).deliver_now!
          # content = "使用者 "+@account.account_name+" 剛註冊成為會員，詳細會員資訊請登入後台查詢。"
          # NewsMailer.system_email("新會員通知",content).deliver_now!
      end
      end
      redirect_to account_levels_path
      else
        redirect_to account_levels_path
      end
  end

    def accountlevel_params
    params.require(:account_level).permit(:level_name,:order_price,:score,:discount)
  end

    def set_accountlevel
    @accountlevel = AccountLevel.find(params[:id])
  end
end