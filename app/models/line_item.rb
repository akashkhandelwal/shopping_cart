class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
  belongs_to :order
  attr_accessible :cart_id, :product_id

  def total_price
  	product.price*quantity
  end

  def delete_product
  	if self.quantity > 1
  		self.quantity -= 1
  		self.save
  	else
  		self.destroy
  	end
  end
end