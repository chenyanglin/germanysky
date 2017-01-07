class SpecialoffersController < ApplicationController
before_filter :current_user
before_action :set_specialoffer, only: [:edit, :update, :destroy]
  def index


        @specialoffers = Specialoffer.all
        @specialoffers = @specialoffers.like(params[:filter]) if params[:filter]
        @specialoffers = @specialoffers.order(updated_at: :desc) if params[:recent]
        @specialoffers_size = @specialoffers.size
        @specialoffers = @specialoffers.page(params[:page]).per(15)
        @specialoffer_infos = false

  end

def new
    @specialoffer = Specialoffer.new
    render :layout => "empty"
  end
  def register
    @specialoffer = Specialoffer.new
    render :layout => "empty"
  end

  def create
    @specialoffer = Specialoffer.new(specialoffer_params)
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
    if @specialoffer.update(specialoffer_params)
      render :text => "success"
    else
      render :text => "error"
    end
  end

def destroy
    @specialoffer.destroy

    redirect_to specialoffers_path
  end

    def specialoffer_params
    params.require(:account_level).permit(:level_name,:order_price,:score,:discount)
  end

    def set_specialoffer
    @specialoffer = Specialoffer.find(params[:id])
  end
end