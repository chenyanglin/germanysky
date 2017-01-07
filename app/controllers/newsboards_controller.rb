class NewsboardsController < ApplicationController
before_filter :current_user
before_action :set_newsboard, only: [:edit, :update, :destroy]
	def index
		    @newsboards = Newsboard.all
        @newsboards = @newsboards.like(params[:filter]) if params[:filter]
        @newsboards = @newsboards.order(updated_at: :desc)
        @newsboards_size = @newsboards.size
        @newsboards = @newsboards.page(params[:page]).per(15)
        @newsboard_info = false
	end


def new
    @newsboard = Newsboard.new
   render :layout => false
  end

  def create
    @newsboard = Newsboard.new(newsboard_params)
    
    if @newsboard.save
      render :text => "success"
    else
      render :text => "error"
    end
  end

  def edit
  @newsboard = Newsboard.find(params[:id])
  render :layout => false
  end

  def update
    @newsboard = Newsboard.find(params[:id])
    if @newsboard.update(newsboard_params)
      render :text => "success"
    else
      render :text => "error"
    end
  end
def show
  @newsboard = Newsboard.find(params[:id])
end
def destroy
    @newsboard.destroy

    redirect_to accounts_path
  end


    def newsboard_params
    params.require(:newsboard).permit(:title,:subtitle,:content)
  end

    def set_newsboard
    @newsboard = Newsboard.find(params[:id])
  end
end
