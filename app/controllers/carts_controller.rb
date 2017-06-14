class CartsController < ApplicationController

  def checkout
    cart = Cart.find(params[:id])
    cart.checkout
    cart.update(status: 'submitted')
    redirect_to cart_path(cart)
  end

  def show
  end
end
