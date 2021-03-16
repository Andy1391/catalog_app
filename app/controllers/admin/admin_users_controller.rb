module Api
  module V1
    class Admin::AdminUsersController < AdminController
      load_and_authorize_resource
      before_action :set_admin_user, only: %i[show update destroy]

      def index
        @admin_users = AdminUser.all
      end

      def show; end      

      def create
        @admin_user = AdminUser.new(admin_user_params)
        if @admin_user.save
          render 'show.rabl', status: 201    
        else
          render json: { error: @admin_user.errors.full_messages }, status: 400 
        end
      end

      def update
        if @admin_user.update(admin_user_params)
          render 'show.rabl', status: 201
        else
          render json: { error: @admin_user.errors.full_messages }, status: 400
        end        
      end

      def destroy
        if @admin_user.destroy
          render json: { message: 'Admin successfully deleted' }, status: 204
        else
          render json: { error: @admin_user.errors.full_messages }, status: 400
        end  
      end

      private

      def set_admin_user
        @admin_user = AdminUser.find(params[:id])  
      end

      def admin_user_params
        params.require(:admin_user).permit(:name, :email, :password, :password_confirmation) 
      end
    end
  end
end
