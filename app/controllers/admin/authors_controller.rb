module Api
  module V1
    class Admin::AuthorsController < AdminController
      load_and_authorize_resource
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

      private

      def author_params
        params.require(:author).permit(:first_name, :last_name)
      end
    end
  end
end
