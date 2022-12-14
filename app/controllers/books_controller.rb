class BooksController < ApplicationController

  def new
    @books = Book.new
  end

  
  # 投稿データの保存
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    redirect_to book_path(@book.id), notice: 'You have created book successfully.' 
    else
      @user=current_user
      @books=Book.all
      render :index
    end
  end

  def index
    @books = Book.all  
    @book = Book.new 
    @user=current_user
  end

  def show
    @book=Book.find(params[:id])
    @user=@book.user
    @book_new=Book.new
    
    
  end
  
  def edit
    @book =Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end 
  end

  def destroy
    book = Book.find(params[:id])  
    book.destroy  
    redirect_to books_path
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      
      redirect_to book_path(@book.id),notice: 'You have updated book successfully.' 
    else
      render :edit
    end
    
  end

  
  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
