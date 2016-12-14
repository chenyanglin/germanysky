class MessagesController < ApplicationController
before_filter :current_user
before_action :set_message, only: [:edit, :update, :destroy,:show]
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
    @message = Message.new(message_params)
    @message.account_id = @current_user.id
    @message.account_name = @current_user.name
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
    @reply = Reply.new
    @message = Message.find(params[:message_id])
    @reply.message_id = params[:message_id]
    @reply.account_id = @current_user.id
    @reply.account_name = @current_user.name
    @reply.content = params[:replycontent]
    if @current_user.role == 1
      @message.update(status: 1)
    else
      @message.update(status: 0)
    end
    if @reply.save
      render :text => "success"
    else
      render :text => "error"
    end
  end

    def message_params
    params.require(:message).permit(:title, :content)
  end
    def set_message
    @message = Message.find(params[:id])
  end
end