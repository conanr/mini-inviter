class Restaurant < ActiveRecord::Base
  attr_accessible :address, :name, :ls_id

  geocoded_by :address
  after_validation :geocode

  validates :name, presence: true
  validates :address, presence: true
  validates :ls_id, presence: true, uniqueness: true

  DEFAULT_NEARBY_RADIUS_MILES = 2

  def self.import_from_ls_page noko_page, ls_id = nil
    ls_id ||= noko_page.css('.yelp_review').first.attributes["id"].value[/\d+/]
    name  = get_name_from_page(noko_page)
    address = get_address_from_page(noko_page)
    create(ls_id: ls_id, name: name, address: address)
  end

  def self.all_close_to address
    near(address, DEFAULT_NEARBY_RADIUS_MILES)
  end

  private

  def self.get_name_from_page(page)
    raw_data = page.css("title").text
    raw_data.sub(": edit your order | LivingSocial Takeout & Delivery","")
  end

  def self.get_address_from_page(page)
    raw_data = page.css("div.info").css("ul").css("li").last.css("p").last.text
    raw_data.sub(" view map","")
  end
end