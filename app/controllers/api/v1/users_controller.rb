module Api
  module V1
    class UsersController < ApplicationController
      respond_to    :json

      def index
        @users = User.all
        render json: { users: @users }, status: 200
      end

      def show; end

      def new
        @user = User.new
      end

      def edit; end

      def create; end

      def update; end

      def destroy; end

      def me
        respond_with current_resource_owner
      end

      def sign_in
        email = params[:email]
        password = params[:password]
        application_id = Doorkeeper::Application.last.id
        
        @user = User.authenticate(email, password)       
          if @user            
            @access_token = Doorkeeper::AccessToken.create!(
              :application_id => application_id,
              :resource_owner_id => @user.id,
              expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
              scopes: ''        
            )            
          else
            head 401
          end
      end     

      # sign_up me update sign_out

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:email, :password)
      end

      def current_resource_owner
        User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end
    end
  end
end
