class MessagesController < ApplicationController
before_filter :current_user
before_action :set_message, only: [:edit, :update, :destroy,:show]
  def index
      if params[:order].present?
        if @current_user.role == 1
          @messages = OrderMessage.all
          @messages = @messages.like(params[:filter]) if params[:filter]
          @messages = @messages.order(updated_at: :desc)
          @messages_size = @messages.size
          @messages = @messages.page(params[:page]).per(15)
        else
          @messages = @current_user.order_messages
          @messages = @messages.like(params[:filter]) if params[:filter]
          @messages = @messages.order(updated_at: :desc)
          @messages_size = @messages.size
          @messages = @messages.page(params[:page]).per(15)
        end
      elsif params[:product].present?
        if @current_user.role == 1
          @messages = ProductMessage.all
          @messages = @messages.like(params[:filter]) if params[:filter]
          @messages = @messages.order(updated_at: :desc)
          @messages_size = @messages.size
          @messages = @messages.page(params[:page]).per(15)
        else
          @messages = @current_user.product_messages
          @messages = @messages.like(params[:filter]) if params[:filter]
          @messages = @messages.order(updated_at: :desc)
          @messages_size = @messages.size
          @messages = @messages.page(params[:page]).per(15)
        end
      else
        if @current_user.role == 1
          @messages = Message.all
          @messages = @messages.like(params[:filter]) if params[:filter]
          @messages = @messages.order(updated_at: :desc)
          @messages_size = @messages.size
          @messages = @messages.page(params[:page]).per(15)
        else
          @messages = @current_user.messages
          @messages = @messages.like(params[:filter]) if params[:filter]
          @messages = @messages.order(updated_at: :desc)
          @messages_size = @messages.size
          @messages = @messages.page(params[:page]).per(15)
        end
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
      content = "使用者 "+@current_user.name.to_s+" 在留言板留下了新留言。<br>主旨："+@message.title.to_s+"<br>內容："+@message.content+"<br>請登入後台回覆留言。"
      NewsMailer.system_email("新留言通知",content).deliver_now!
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
  def product_message
  @message = ProductMessage.find(params[:id])
  render :layout => false
  end
  def order_message
  @message = OrderMessage.find(params[:id])
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
      content_to_user = "您的留言「"+@message.content.to_s+"」有了新回覆。"
      NewsMailer.normal_email("留言回覆通知",content_to_user,@message.account_id).deliver_now!
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