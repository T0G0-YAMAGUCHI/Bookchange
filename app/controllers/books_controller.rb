class BooksController < ApplicationController
  
  def index
    @books=Book.search(params[:search])

  end
  
  def show
    @book=Book.find(params[:id])
    @user=@book.user
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


  
  private
  
  def book_params
    params.require(:book).permit(:title,:explain,:image)
  end
end
