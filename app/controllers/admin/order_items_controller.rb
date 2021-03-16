module Api
  module V1
    class Admin::OrderItemsController < AdminController
      
      def create
        @order_item = OrderItem.new(order_item_params)       
      end

      private    

      def order_item_params
        params.require(:order_item).permit(:quantity, :order_id, :book_id) 
      end
    end
  end
end