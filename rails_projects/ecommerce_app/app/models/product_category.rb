class ProductCategory
  include MongoMapper::EmbeddedDocument

  key :shop_category_id,  ObjectId
  key :product_group,     String, :length => { :in => 0..25 }
  key :product_subgroup,  String, :length => { :in => 0..25 }
  key :product_type,      String, :length => { :in => 0..25 }
  key :product_gender,    String, :length => { :in => 0..25 }
  key :other_product_category,     String, :length => { :in => 0..25 }
  key :product_size, Array, :length => { :in => 0..25 }
  key :product_box_size, Array, :length => { :in => 0..25 }
  key :product_bottle_size, Array, :length => { :in => 0..25 }
  key :product_pack_size, Array, :length => { :in => 0..25 }
  key :product_service_time, Array, :length => { :in => 0..25 }
  key :product_color, Array, :length => { :in => 0..25 }
  key :other, Array, :length => { :in => 0..25 }
#  validates :product_group, :product_subgroup, :product_type, :product_gender, 
#    presence: true, format: { with: VALID_CATEGORY_REGEX }, uniqueness: { case_sensitive: false }
  
  timestamps!
#  userstamps!

  embedded_in :shop_category

  def full_line
    "#{product_group} || #{product_subgroup} || #{product_type} || #{product_gender} || #{other_product_category}
    #{product_size} || #{product_box_size} || #{product_bottle_size} || #{product_pack_size} || #{product_service_time}
    #{product_color} || #{other}"
  end
end
