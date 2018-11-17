class BooksController < ApplicationController
before_action :require_user_logged_in , only:[:show,:new,:create ,:book_sets ,:book_removes]
  def index
    @search = Book.ransack(params[:q])
    @books = @search.result(distinct: true).order("created_at DESC").page(params[:page])
    
    
  end
  
  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @order = Order.find_by(book_id: @book.id)
    @wanters = @book.wanters.includes(:orders)
    @message = @book.messages.build(user_id: current_user.id)
    @messages = @book.messages.page(params[:page])
  end
  
  def new
    @book=Book.new
  end

  def create
    @book=current_user.books.build(book_params)
    if @book.save
      flash[:success]="本を出品しました"
      redirect_to @book
    else 
      flash.now[:danger]="本の出品に失敗しました"
      render "new"
    end
  end

  def book_sets
    book = Book.find(params[:id])
    user = User.find(params[:user_id])
    order = user.orders.find_by(book_id: book.id)
    book.update(order_id: order.id)
    point = current_user.books.where.not(order_id: nil).count - Book.where(order_id: Order.where(user_id: current_user.id).ids).count
    current_user.update(point: point)
    redirect_back(fallback_location: root_url)
  end

  def book_removes
    book = Book.find(params[:id])
    book.update(order_id: nil)
    point = current_user.books.where.not(order_id: nil).count - Book.where(order_id: Order.where(user_id: current_user.id).ids).count
    current_user.update(point: point)
    redirect_back(fallback_location: root_url)
  end
  


  
  private
  
  def book_params
    params.require(:book).permit(:title,:explain,:image)
  end
end
