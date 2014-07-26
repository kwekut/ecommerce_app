class Product
  include MongoMapper::EmbeddedDocument

  key :user_id,  ObjectId
  key :product_title, String,	:length => { :in => 3..15 }
  key :product_info, String,	:length => { :in => 3..50 }
  key :product_image, String
  key :product_price, Integer,	:length => { :in => 3..15 }
  key :product_quantity, Integer,  :length => { :in => 3..15 }
  key :product_quantity_ordered, Integer,  :length => { :in => 3..15 }
  key :product_category, String,  :length => { :in => 3..15 }
  timestamps!

  belongs_to :user

end
