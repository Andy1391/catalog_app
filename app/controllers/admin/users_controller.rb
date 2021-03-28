module Api
  module V1
    class Admin::UsersController < AdminController
      load_and_authorize_resource
      before_action :set_user, only: %i[show update destroy]

      def index
        @users = User.all
        render json: { users: @users }, status: 200
      end

      def show; end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user, status: 201
        else
          render json: { error: @user.errors.full_messages }, status: 400
        end
      end

      def update
        if @user.update(user_params)
          render json: { message: 'User successfully updated' }, status: 204
        else
          render json: { message: 'Bad request' }, status: 400
        end
      end

      def destroy
        if @user.destroy
          render json: { message: 'Book successfully deleted' }, status: 204
        else
          render json: { message: 'Bad request' }, status: 400
        end
      end   

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:name, :email, :role, :password, :password_confirmation)
      end
    end
  end
end
