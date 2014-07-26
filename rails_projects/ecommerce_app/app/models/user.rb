class User
  include MongoMapper::Document
  include Geocoder::Model::MongoMapper
  include ActiveModel::SecurePassword

  key :name, String,  :length => { :in => 3..15 }, :unique => true, :required => true
  key :email, String
  key :address, String,   :length => { :in => 3..50 }, :required => true
  key :phone, String,   :length => { :in => 10..20 }, :required => true
  key :password, String,  :length => { :in => 6..25 }
  key :password_digest, String
  key :remember_token, String
  key :active, Boolean
  key :admin, Boolean 
  key :coordinates, :type => Array
  key :location, :type => Hash

  before_create :create_remember_token
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
 
  timestamps!
  has_secure_password

  geocoded_by :address, :skip_index => true    # can also be an IP address
  after_validation :geocode, :if => :address_changed?
#  before_save self.location = {type: "Point", coordinates: self.coordinates}

  one :shop, dependent: :destroy
  many :products, dependent: :destroy
  many :orders, dependent: :destroy

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
  
end
