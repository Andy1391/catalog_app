module Api
  module V1
    class BooksController < ApplicationController
      before_action :set_book, only: %i[show edit update destroy]
      before_action :authenticate_user!

      def index
        @books = Book.all
      end

      def show; end

      def new
        @book = Book.new
      end

      def edit; end

      def create
        @book = Book.new(book_params)

        respond_to do |format|
          if @book.save
            format.json { render :show, status: :created, location: @book }
          else
            format.json { render json: @book.errors, status: :unprocessable_entity }
          end
        end
      end

      def update
        respond_to do |format|
          if @book.update(book_params)
            format.json { render :show, status: :ok, location: @book }
          else
            format.json { render json: @book.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @book.destroy
        respond_to do |format|
          format.json { head :no_content }
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
