class Shop
  include MongoMapper::EmbeddedDocument

  key :user_id,  ObjectId
  key :shop_category, Array,  :length => { :in => 1..5 }
  key :shop_title, String,    :length => { :in => 3..20 }
  key :shop_banner, String
  key :shop_info, String,   :length => { :in => 20..200 }
  key :shop_about, String,    :length => { :in => 20..300 }
  key :shop_hours, String
  key :shop_phone, String
  key :shop_url, String  
  key :shop_gallery, String
  key :shop_slug, String  
  timestamps!

  belongs_to :user
end


