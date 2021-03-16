class HomeController < ApplicationController
  def index
    @q = Book.ransack(params[:q])
    @books = @q.result.order(:title).page params[:page]
  end
end
