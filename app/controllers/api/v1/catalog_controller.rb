module Api
  module V1
    class CatalogController < ApplicationController
      def index
        @books = Book.all
        render json: { books: @books }, status: 200
      end
    end
  end
end
