module Api
  module V1
    class UsersController < ApplicationController
      load_and_authorize_resource
      before_action :set_user, only: %i[show update]
      respond_to :json

      def index
        @users = User.all
        render json: { users: @users }, status: 200
      end

      def show; end      

      def update; end      

      def me
        respond_with current_resource_owner
      end
      # rubocop:disable Metrics/AbcSize

      def sign_in
        email = params[:email]
        password = params[:password]
        client_id = params[:client_id]
        client_secret = params[:client_secret]

        application_id = Doorkeeper::Application.find_by(
          secret: client_secret,
          uid: client_id
        ).id

        @user = User.authenticate(email, password)

        if @user
          @access_token = Doorkeeper::AccessToken.create!(
            application_id: application_id,
            resource_owner_id: @user.id,
            expires_in: Doorkeeper.configuration.access_token_expires_in.to_i
          )
        else
          render(json: { error: @user.errors.full_messages }, status: 401)
        end
      end

      def sign_up
        @user = User.new(
          email: params[:email],
          password: params[:password],
          password_confirmation: params[:password_confirmation]
        )

        client_id = params[:client_id]
        client_secret = params[:client_secret]

        application_id = Doorkeeper::Application.find_by(
          secret: client_secret,
          uid: client_id
        ).id

        if @user.save
          @access_token = Doorkeeper::AccessToken.create!(
            application_id: application_id,
            resource_owner_id: @user.id,
            expires_in: Doorkeeper.configuration.access_token_expires_in.to_i
          )
        else
          render(json: { error: @user.errors.full_messages }, status: 422)
        end
      end
      # rubocop:enable Metrics/AbcSize

      def log_out
        client_id = params[:client_id]
        client_secret = params[:client_secret]
        application_id = Doorkeeper::Application.find_by(
          secret: client_secret,
          uid: client_id
        ).id
        resource_owner = current_resource_owner

        Doorkeeper::AccessToken.revoke_all_for(application_id, resource_owner)
      end

      private

      def set_user
        @user = User.find(params[:id]) 
      end

      def current_resource_owner
        User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end
    end
  end
end
