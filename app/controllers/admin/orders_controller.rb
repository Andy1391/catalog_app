module Api
  module V1
    class Admin::OrdersController < AdminController
      load_and_authorize_resource
      before_action :set_order, only: %i[show update destroy check_book_quantity]

      def index
        @orders = Order.all
      end

      def show
        @books_order = @order.books
      end

      def create
        if params[:book_id]
          @order = Order.new
          check_book_quantity
          @order.total_price = @order.total_price          
        else
          @order = Order.new(order_params)
          @order.total_price = total_price          
        end
        @order.save
      end

      def update
        if params[:book_id]
          check_book_quantity          
        else
          @order.update(order_params)          
        end
        render 'show.rabl'
      end

      def destroy
        if @order.destroy
          render json: { message: 'Order successfully deleted' }, status: 204
        else
          render json: { error: @order.errors.full_messages }, status: 400
        end
      end

      private

      def check_book_quantity
        @book = Book.find(params[:book_id])
        @order_books = @order.order_items
        @book_in_order = @order_books.to_a.to_s.include?("#{params[:book_id]}")
        if @book_in_order
          @order_item = OrderItem.where(book_id: params[:book_id], order_id: @order).first
          @order_item.quantity += 1
          @order_item.save
        else
          @books_order = @order.books
          @books_order << @book
        end
      end

      def set_order
        @order = Order.find(params[:id])
      end

      def order_params
        params.require(:order).permit(:name, :phone, :adress, :email, :total_price, :status)
      end
    end
  end
end
