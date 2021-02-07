module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :set_category, only: %i[show update destroy]

      def index
        @categories = Category.all
      end

      def show; end

      private

      def set_category
        @category = Category.find(params[:id])
      end
    end
  end
end
