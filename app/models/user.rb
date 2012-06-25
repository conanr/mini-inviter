class User < ActiveRecord::Base
  attr_accessible :email, :foursquare_id, :first_name, :last_name
  
  def self.create_from_oauth_hash(oauth_hash)
    find_or_create_by_foursquare_id(foursquare_id: oauth_hash["uid"],
      first_name: oauth_hash["info"]["first_name"],
      last_name: oauth_hash["info"]["last_name"],
      email: oauth_hash["info"]["email"])
  end
end