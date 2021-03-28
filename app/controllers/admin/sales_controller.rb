module Api
  module V1
    class Admin::SalesController < AdminController
      def index
        @q = OrderItem.joins(:order).select(:book_id, :quantity, :order_id).where('orders.status = 3').ransack(params[:q])
        @sales = @q.result.order(:book_id).page params[:page]
      end
    end
  end
end
