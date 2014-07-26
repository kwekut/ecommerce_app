class Order
  include MongoMapper::EmbeddedDocument

  key :invoice, String,	:length => { :in => 1..15 }
  key :total_price, Integer

  timestamps!
#  userstamps!

  many :transactions
end


class Transaction
  include MongoMapper::EmbeddedDocument

  key :order_id, ObjectId
  key :product_id, ObjectId
  key :quantity, Integer,	:length => { :in => 1..20 }
  key :price, Integer
end

# class Order
#   include MongoMapper::EmbeddedDocument

#   key :invoice, String,	:length => { :in => 1..15 }

#   many :line_items
#   timestamps!
# #  userstamps!

#   belongs_to :user
# end

# class LineItem
#   include MongoMapper::EmbeddedDocument

#   key :order_id, ObjectId
#   key :product_id, String
#   key :quantity, Integer,	:length => { :in => 1..20 }
#   key :price, Integer,		:length => { :in => 1..15 }
# end
