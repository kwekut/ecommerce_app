VALID_CATEGORY_REGEX = /\A[[:alpha:]]+\z/i

class ShopCategory
  include MongoMapper::Document

  key :industry,    String, :length => { :in => 1..25 }
  key :segment,     String, :length => { :in => 1..25 }
  key :specialty,   String, :length => { :in => 1..25 }
  key :product_type, String, :length => { :in => 1..25 }
  key :other,       String, :length => { :in => 1..25 }

#  validates :industry, :segment, :specialty, :product_type, :other, presence: true, format: { with: VALID_CATEGORY_REGEX }, uniqueness: { case_sensitive: false }
#  before_save { self.industry = industry.downcase, self.segment = segment.downcase, self.specialty = specialty.downcase, self.product_type = product_type.downcase, self.other = other.downcase }
  timestamps!
#  userstamps!
  many :product_categories, dependent: :destroy


  def full_line
    "#{industry} || #{segment} || #{specialty} || #{product_type} || #{other}"
  end
end  

#form for categoryies
# website > http://api.rubyonrails.org/classes/ActionView/Helpers/FormOptionsHelper.html#method-i-collection_select
#<%= f.label :project_id %>
#<%= f.collection_select :project_id, Project.all, :id, :name %>

#object.collection_select :attribute, Pull.all, :id, :description - my own english
#collection_select(object, method, collection, value_method, text_method, options = {}, html_options = {}) 
#collection_select(:post, :author_id, Author.all, :id, :name_with_initial, prompt: true)


#grouped_collection_select(object, method, collection, group_method, group_label_method, option_key_method, option_value_method, options = {}, html_options = {}) 
#grouped_collection_select(:city, :country_id, @continents, :countries, :name, :id, :name)

#grouped_options_for_select(grouped_options, selected_key = nil, options = {})
#Ex. ["North America",[["United States","US"],["Canada","CA"]]]

#option_groups_from_collection_for_select(collection, group_method, group_label_method, option_key_method, option_value_method, selected_key = nil) 
#option_groups_from_collection_for_select(@continents, :countries, :name, :id, :name, 3)
