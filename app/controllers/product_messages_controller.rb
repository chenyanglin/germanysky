class ProductMessagesController < ApplicationController
before_filter :current_user
before_action :set_pruductmessage, only: [:edit, :update, :destroy,:show]
  def index

        if @current_user.role == 1
        @messages = Message.all
        @messages = @messages.like(params[:filter]) if params[:filter]
        @messages = @messages.order(updated_at: :desc) if params[:recent]
        @messages_size = @messages.size
        @messages = @messages.page(params[:page]).per(15)
      else
        @messages = @current_user.messages
        @messages = @messages.like(params[:filter]) if params[:filter]
        @messages = @messages.order(updated_at: :desc) if params[:recent]
        @messages_size = @messages.size
        @messages = @messages.page(params[:page]).per(15)
      end


  end
def new
    @message = Message.new
  
  end

  def create
    @message = ProductMessage.new
    @message.account_id = @current_user.id
    @message.account_name = @current_user.name
    @message.content = params[:replycontent]
    @message.product_id = params[:product_id]
    @message.status = 0
    if @message.save
    	render :text => "success"
	else
		render :text => "error"
	end
  end

  def edit
    render :layout => false
  end

  def update
    if @message.update(message_params)
      render :text => "success"
    else
      render :text => "error"
    end
  end
  def show
    @reply = Reply.new
  render :layout => false
  end
  def destroy
    @message.destroy

    redirect_to messages_path
  end
  def reply
    @message = ProductMessage.find(params[:message_id])
    if @message.update(reply: params[:replycontent])
      @message.update(status: 1)
      render :text => "success"
    else
      render :text => "error"
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
    def set_pruductmessage
    @message = ProductMessage.find(params[:id])
  end
end