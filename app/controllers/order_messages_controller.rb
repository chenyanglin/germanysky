class OrderMessagesController < ApplicationController
before_filter :current_user
before_action :set_ordermessage, only: [:edit, :update, :destroy,:show]
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
    @message = OrderMessage.new
    @message.account_id = @current_user.id
    @message.account_name = @current_user.name
    @message.content = params[:replycontent]
    @message.order_id = params[:order_id]
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
    @message = OrderMessage.find(params[:message_id])
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
    def set_ordermessage
    @message = OrderMessage.find(params[:id])
  end
end