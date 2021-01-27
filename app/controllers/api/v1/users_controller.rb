module Api
  module V1
    class UsersController < ApplicationController
      def index
        @users = User.all
      end

      def show; end

      def new
        @user = User.new
      end

      def edit; end

      def create; end

      def update; end

      def destroy
        @user.destroy
        respond_to do |format|
          format.json { head :no_content }
        end
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params; end
    end
  end
end
