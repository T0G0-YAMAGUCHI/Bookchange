class MessagesController < ApplicationController
before_action :require_user_logged_in
before_action :correct_user, only: [:destroy]

  def create
    #binding.pry
    @message = current_user.messages.build(message_params)
    @message.book_id = params[:book_id]
    if @message.save
      redirect_to book_url(@message.book_id)
    else
      flash[:danger] = "メッセージの送信に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end
  
  def destroy
    @message.destroy
    flash[:success]="メッセージを削除しました"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def message_params
    params.require(:message).permit(:content)
  end
  
  def correct_user
    @message = current_user.find_by(id: params[:id])
    unless @message
      redirect_back(fallback_location: root_path)
    end
  end
  
  
  
end
