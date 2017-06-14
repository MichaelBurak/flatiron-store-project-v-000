class Cart < ActiveRecord::Base
  has_many :items, :through => :line_items
  has_many :line_items
  belongs_to :user

  def total
    total = 0
    self.line_items.each do |line_item|
      total += (line_item.item.price * line_item.quantity)
    end
    total
  end

  def add_item(item_id)
  item = Item.find(item_id)
  if self.items.include?(item)
    existing_line_item = self.line_items.find_by(item: item)
    existing_line_item.quantity += 1
    existing_line_item
  else
    line_items.new(item_id: item_id, cart_id: self, quantity: 1)
  end
  end

  def checkout
    user.delete_cart
    line_items.each do |line_item|
      found_item = Item.find(line_item.item_id)
      found_item.inventory -= line_item.quantity
      found_item.save
    end
  end

end
