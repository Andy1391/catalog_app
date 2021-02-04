module Api
  module V1
    class BooksController < ApplicationController
      before_action :set_book, only: %i[show edit update destroy]
      before_action :doorkeeper_authorize!   

      def index
        @books = Book.all
        render json: { books: @books }, status: 200
      end

      def show
        render json: { book: @book }, status: 200
      end

      def new; end

      def edit; end

      def create
        @book = Book.new(book_params)
        if @book.save
          render json: @book, status: 201
        else
          render json: { message: 'Bad request' }, status: 400
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
        params.require(:book).permit(:title, :author, :category, :price)
      end
    end
  end
end
