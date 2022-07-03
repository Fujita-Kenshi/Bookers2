class BooksController < ApplicationController
    
    def new
        @book = Book.new
    end
    
    def create
        @book = Book.new(book_params)       # 投稿情報(form_with)の代入
        @book.user_id = current_user.id     # Log_in中のuser情報(.id)を@bookのuser_idへ代入
        if  @book.save                          # 投稿情報の保存
            flash[:notice] = "You have created book successfully."
            redirect_to book_path(@book)
        else
            @books = Book.all
            render :index
        end
    end

    def index
        @book = Book.new    # 表示をするための空変数
        @books = Book.all
    end
    
    def show
        @book = Book.find(params[:id])
        @user = @book.user
        @book = Book.new
        @book_show = Book.find(params[:id])
        # @book_show.user_id = current_user.id
    end
    
    def edit
        @book = Book.find(params[:id])
        if @book.user == current_user
            # redirect_to edit_book_path(@book)
        else
            redirect_to books_path
        end
    end
    
    def update
        @book = Book.find(params[:id])
        # @user = @book.user
        if  @book.update(book_params)
            flash[:notice] = "You have updated book successfully."
            redirect_to book_path(@book)
        else
            render :edit
        end
    end
    
    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to books_path
    end
    
    private
    
    def book_params
        params.require(:book).permit(:title, :body)  #, :image
    end
    
end