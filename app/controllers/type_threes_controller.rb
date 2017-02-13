class TypeThreesController < ApplicationController
before_filter :current_user
before_action :set_type, only: [:edit, :update, :destroy]
  def index

      if params[:deleted].present?
        @del_accounts = Account.unscoped.where("manager_id = ? AND deleted = true",@current_user.id).page(params[:page])
        @accounts_size = @del_accounts.size
      else
        @types = TypeOne.all
        @types = @types.like(params[:filter]) if params[:filter]
        @types = @types.order(updated_at: :desc) if params[:recent]
        @types_size = @types.size
        @types = @types.page(params[:page]).per(15)
    	end

  end
def new
    @typeone = TypeOne.new
    render :layout => false
  end

  def create
    # binding.pry
if params[:parent_id] == ''
  @typeone = TypeOne.new(type_params)
  if @typeone.save
    	render :text => "success"
	else
		render :text => "error"
	end
elsif params[:parent_two_id]==''
  @typetwo = TypeTwo.new(type_params)
  @typetwo.type_one_id = params[:parent_id]
  if @typetwo.save
      render :text => "success"
  else
    render :text => "error"
  end
else
  @typethree = TypeThree.new(type_params)
  @typethree.type_two_id = params[:parent_two_id]
  if @typethree.save
      render :text => "success"
  else
    render :text => "error"
  end
end
  end

  def edit
    render :layout => false
  end

  def update
    if @typeone.update(type_params)
      render :text => "success"
    else
      render :text => "error"
    end
  end

def destroy
    @typeone.destroy

    redirect_to type_ones_path
  end
  def type_two_get
    id = params[:typeone_id]
    @typetwos = TypeOne.find(id).type_twos
    render json: @typetwos
  end
  def type_three_get
    id = params[:typetwo_id]
    @typethrees = TypeTwo.find(id).type_threes
    # binding.pry
    render json: @typethrees
  end

    def type_params
    params.require(:type_one).permit(:name, :description)
  end
    def set_type
    @typeone = TypeOne.find(params[:id])
  end
end
