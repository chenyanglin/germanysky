class NewslettersController < ApplicationController
before_filter :current_user
before_filter :setting
before_action :set_newsletter, only: [:edit, :update, :destroy]
	def index
		    @newsletters = Newsletter.all
        @newsletters = @newsletters.like(params[:filter]) if params[:filter]
        @newsletters = @newsletters.order(updated_at: :desc) if params[:recent]
        @newsletters_size = @newsletters.size
        @newsletters = @newsletters.page(params[:page]).per(15)
        @newsletter_info = false
        @email_size = NewsletterEmail.all.size
	end


def new
    @newsletter = Newsletter.new
   render :layout => false
  end

  def create
    NewsMailer.news_email(params[:newsletter][:subject],params[:newsletter][:content]).deliver_now!
    @newsletter = Newsletter.new(newsletter_params)
    
    if @newsletter.save
      render :text => "success"
    else
      render :text => "error"
    end
  end

  def edit
  @newsletter = Newsletter.find(params[:id])
  render :layout => false
  end

  def update
    @newsletter = Newsletter.find(params[:id])
    if @newsletter.update(newsletter_params)
      render :text => "success"
    else
      render :text => "error"
    end
  end
def show
  @newsletter = Newsletter.find(params[:id])
end
def destroy
    @newsletter.destroy

    redirect_to accounts_path
  end


    def newsletter_params
    params.require(:newsletter).permit(:subject,:content)
  end

    def set_newsboard
    @newsletter = Newsletter.find(params[:id])
  end
end
