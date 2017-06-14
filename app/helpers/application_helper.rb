module ApplicationHelper

  def current_cart
    if user_signed_in?
      current_user.current_cart
    end
  end
end
