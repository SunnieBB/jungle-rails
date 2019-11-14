class Admin::DashboardController < ApplicationController
  
  http_basic_authenticate_with name: ENV["USERNAME"], password: ENV["PASSWORD"]

  def show
    @product = Product.count
    @category = Category.count
  end

end
