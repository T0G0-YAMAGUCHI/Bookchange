class OrdersController < ApplicationController
  def create
    @book = Book.find_or_initialize_by(id: params[:book_id])
    current_user.want(@book)
    flash[:success]="リクエストを送信しました"
    
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @book = Book.find(params[:book_id])
    if Order.find(@book.order_id).user == current_user
      @book.order_id = nil
      @book.save
    end
    current_user.unwant(@book)
    flash[:success]="リクエストを解除しました"
    
    redirect_to root_url
  end
end
