class MessagesController < ApplicationController
  before_action :require_user
  def create
    message = current_user.messages.build(msg_params)
    if message.save
      flash[:notice] = "#{@current_user.username} is added new message."
      redirect_to root_path
    end
  end
  private
  def msg_params
    params.require(:message).permit(:body, :user_id)
  end
end
