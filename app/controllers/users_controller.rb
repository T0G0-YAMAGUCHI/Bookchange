class UsersController < ApplicationController
  before_action :require_user_logged_in , only:[:show , :purchased_books]
  
  def show
    @user=User.find(params[:id])
    @books=@user.books.order("created_at DESC").page(params[:page])
    if current_user == @user
      current_user.books.each do |book|
        plus = book.orders.where(check: true).count
        point = plus - Book.where(order_id: Order.where(user_id: current_user.id).ids).count
        current_user.update(point: point)
      end    
    end
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    
    if @user.save
      flash[:success]="ユーザを登録しました"
      redirect_to login_url
    else 
      flash[:danger]="ユーザの登録に失敗しました"
      redirect_to root_url
    end
  end
  
  def purchased_books
    @user=User.find(params[:id])
    @purchased_books = Book.where(order_id: Order.where(user_id: @user.id))
  end
  
  def want_books
    @user=User.find(params[:id])
    @want_books = @user.want_books
  end
  

    
  private
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
end
