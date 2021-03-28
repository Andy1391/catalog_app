module Api
  module V1
    class Admin::BooksController < AdminController
      load_and_authorize_resource
      before_action :set_book, only: %i[show edit update destroy]
      before_action :doorkeeper_authorize!

      def index
        @books = Book.all
      end

      def show; end

      def create
        @book = Book.new(book_params)
        @book.category_id = params[:category_id]
        @book.author = Author.find(params[:author_id])

        if @book.save
          render json: @book, status: 201
        else
          render json: { error: @book.errors.full_messages }, status: 400
        end
      end

      def update
        if @book.update(book_params)
          render json: { book: @book }, status: 204
        else
          render json: { message: 'Bad request' }, status: 400
        end
      end

      def destroy
        if @book.destroy
          render json: { message: 'Book successfully deleted' }, status: 204
        else
          render json: { message: 'Bad request' }, status: 400
        end
      end

      private

      def set_book
        @book = Book.find(params[:id])
      end

      def book_params
        params.require(:book).permit(:title, :price, :author_id, :category_id)
      end
    end
  end
end
