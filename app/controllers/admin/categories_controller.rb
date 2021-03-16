module Api
  module V1
    class Admin::CategoriesController < AdminController
      load_and_authorize_resource
      before_action :set_category, only: %i[show update destroy]

      def index
        @categories = Category.all
      end

      def show; end

      def create
        @category = Category.new(category_params)
        if @category.save
          render json: { category: @category }, status: 201
        else
          render json: { error: @category.errors.full_messages }, status: 400
        end
      end

      def update
        if @category.update(category_params)
          render 'show.rabl', status: 201
        else
          render json: { error: @category.errors.full_messages }, status: 400
        end
      end

      def destroy
        if @category.destroy
          render json: { message: 'Category successfully deleted' }, status: 204
        else
          render json: { error: @category.errors.full_messages }, status: 400
        end
      end

      private

      def set_category
        @category = Category.find(params[:id])
      end

      def category_params
        params.require(:category).permit(:name)
      end
    end
  end
end
