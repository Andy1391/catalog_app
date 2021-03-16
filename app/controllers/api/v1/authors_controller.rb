module Api
  module V1
    class AuthorsController < ApplicationController
      load_and_authorize_resource
      before_action :set_author, only: %i[update destroy]
      
      def index
        @authors = Author.all
        render json: { authors: @authors }, status: 200
      end

      def create
        @author = Author.new(author_params)
        if @author.save
          render json: @author, status: 201
        else
          render json: { message: 'Bad request' }, status: 400
        end
      end

      def update        
        if @author.update(author_params)
          render 'show.rabl', status: 201
        else
          render json: { error: @author.errors.full_messages }, status: 400
        end       
      end

      def destroy
        if @author.destroy
          render json: { message: 'Author successfully deleted' }, status: 204
        else
          render json: { error: @author.errors.full_messages }, status: 400
        end         
      end

      private

      def set_author
        @author = Author.find(params[:id])  
      end

      def author_params
        params.require(:author).permit(:first_name, :last_name)
      end
    end
  end
end
