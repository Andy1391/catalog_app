class AdminController < ApplicationController
  before_action :authorized?

  private

  def authorized?
    unless current_admin_user
      redirect_to root_path, flash: { error: "You are not authorized to view that page." }
    end
  end
end
