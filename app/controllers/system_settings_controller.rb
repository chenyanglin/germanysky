class SystemSettingsController < ApplicationController
before_filter :current_user
before_filter :setting
before_filter :manager_account
  def index
        @systemsetting = SystemSetting.find(1)
  end

  def new
    render :layout => "empty"
  end
  def create
    
      render :text => "success"
  end

  def edit
    render :layout => "empty"
  end

  def update
    @systemsetting = SystemSetting.find(1)
    if params[:switch]=="on"
      @systemsetting.update(free_shipping_switch: 1)
      @systemsetting.update(free_shipping_limit: params[:system_setting][:free_shipping_limit])
    else
      @systemsetting.update(free_shipping_switch: 0)
    end
      render :text => "success"

  end

  def destroy
   
  end

  def systemsetting_params
    params.require(:systemsetting).permit()
  end

end