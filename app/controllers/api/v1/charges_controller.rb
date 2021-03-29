module Api
  module V1
    class ChargesController < ApplicationController
      rescue_from Stripe::CardError, with: :catch_exception

      def new
        @order = Order.find(params[:order_id])
        @amount = @order.total_price
        session[:amount] = @amount
        session[:order] = @order
        @order_items = @order.order_items
      end

      def create
        @amount = session[:amount].to_f
        order = session[:order]
        id = order['id']
        @order = Order.find(id)
        price_to_cent
        price_to_integer

        charge = Stripe::Charge.create({
          source:  params[:stripeToken],
          amount:  @amount,
          description:  'Rails Stripe customer',
          currency: 'usd'
        })

        unless charge.nil?
          @order.update(status: :confirmed)
        end

        session.delete(:amount)
        session.delete(:order)

        rescue Stripe::CardError => e
          flash[:error] = e.message
          redirect_to new_api_v1_charge_path
      end

      private

      def charges_params
        params.permit(:stripeToken, :order_id)
      end

      def price_to_cent
        @amount *= 100
      end

      def price_to_integer
        @amount = @amount.to_i
      end

      def catch_exception(exception)
        flash[:error] = exception.message
      end
    end
  end
end
