module Api
  module V1
    class ChargesController < ApplicationController
      rescue_from Stripe::CardError, with: :catch_exception
      
      def new
        @order = Order.find(params[:order_id])
        @amount = @order.total_price
        @order_items = @order.order_items
      end

      def create
        @amount = 123

        customer = Stripe::Customer.create({
          email: params[:stripeEmail],
          source: params[:stripeToken],
        })

        charge = Stripe::Charge.create({
          customer: customer.id,
          amount: @amount,
          description: 'Rails Stripe customer',
          currency: 'usd',
        })

        if charge
          render json: { message: 'Thank you for your purchase' }, status: 201
        else
          render json: { message: 'Bad request' }, status: 400
        end
      end

      private

      def charges_params
        params.permit(:stripeEmail, :stripeToken, :order_id)
      end

      def catch_exception(exception)
        flash[:error] = exception.message
      end
    end    
  end
end