module Api
  module V1
    class Admin::DashboardsController < AdminController
      MONTH_FROM_YEAR = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11].freeze
      TOP_QUANTITY_BOOKS = 10
      ORDER_DELIVERED_STATUS = 3

      def index
        one_year_ago = DateTime.now - 1.year
        begining_of_month_start_date = one_year_ago.beginning_of_month.beginning_of_day
        end_of_month_start_date = one_year_ago.end_of_month.end_of_day

        @books = []
        @books <<
          MONTH_FROM_YEAR.map do |current_month|
          {
            Date::MONTHNAMES[(DateTime.now + current_month.month).month] => OrderItem
            .joins(:order)
            .where('orders.status = ? and orders.created_at BETWEEN ? AND ?',
                    ORDER_DELIVERED_STATUS, begining_of_month_start_date + current_month.month, end_of_month_start_date + current_month.month)
            .group('order_items.book_id').order('sum_order_items_quantity desc').limit(TOP_QUANTITY_BOOKS).sum('order_items.quantity')
            .map { |k, v| { book_id: k, quantity: v } }
          }
        end
      end

      def index2
        one_year_ago = Time.now - 1.year
        begining_of_month_start_date = one_year_ago.beginning_of_month.beginning_of_day
        end_of_month_start_date = one_year_ago.end_of_month.end_of_day

        @summ = []
        @summ <<
          MONTH_FROM_YEAR.map do |current_month|
            {
              Date::MONTHNAMES[(DateTime.now + current_month.month).month] => Book
              .joins(:orders)
              .select('SUM(books.price * quantity) AS total_sum, books.author_id as author_id, books.price as book_price, order_items.quantity as quantity')
              .where('orders.status = ? AND orders.created_at BETWEEN ? AND ?',
                      ORDER_DELIVERED_STATUS, begining_of_month_start_date + current_month.month, end_of_month_start_date + current_month.month)
              .group('author_id, book_price, quantity').order('total_sum desc').limit(TOP_QUANTITY_BOOKS)
              .map { |a| { total_sum: a.total_sum.to_f, author_id: a.author_id } }
            }
          end
      end

      def index3
        @months = MONTH_FROM_YEAR
      end

      def index3_data
        @month = params[:a].to_i

        one_year_ago = Time.now - 1.year
        begining_of_month_start_date = one_year_ago.beginning_of_month.beginning_of_day
        end_of_month_start_date = one_year_ago.end_of_month.end_of_day

        @summ = []
        @summ <<
          [@month].map do |current_month|
            {
              Date::MONTHNAMES[(DateTime.now + current_month.month).month] => Book
              .joins(:orders)
              .select('SUM(books.price * order_items.quantity) AS total_sum')
              .where('orders.status = ? AND orders.created_at BETWEEN ? AND ?',
                      ORDER_DELIVERED_STATUS, begining_of_month_start_date + current_month.month, end_of_month_start_date + current_month.month)
              .map { |a| a.total_sum.to_f }
            }
          end

        @month = @summ.first.map(&:keys).flatten
        @amount = @summ.first.map(&:values).flatten

        render json: {
          data: @amount,
          month: @month
        }
      end

      def index4_data
        one_year_ago = Time.now - 1.year
        begining_of_month_start_date = one_year_ago.beginning_of_month.beginning_of_day
        end_of_month_start_date = one_year_ago.end_of_month.end_of_day

        @summ = []
        @summ <<

          MONTH_FROM_YEAR.map do |current_month|
            {
              Date::MONTHNAMES[(DateTime.now + current_month.month).month] => Book
              .joins(:orders)
              .select('SUM(books.price * order_items.quantity) AS total_sum')
              .where('orders.status = ? AND orders.created_at BETWEEN ? AND ?',
                      ORDER_DELIVERED_STATUS, begining_of_month_start_date + current_month.month, end_of_month_start_date + current_month.month)
              .map { |a| a.total_sum.to_f }
            }
          end

        @months = @summ.first.map(&:keys).flatten
        @amount = @summ.first.map(&:values).flatten

        render json: {
          data: @amount,
          months: @months
        }
      end
    end
  end
end
