module Api
  module V1
    class OrderItemsController < ApplicationController
      
      def create        
      end

      private    

      def order_item_params
        params.require(:order_item).permit(:quantity, :order_id, :book_id, :amount) 
      end
    end
  end
end