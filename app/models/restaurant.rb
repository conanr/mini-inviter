class Restaurant < ActiveRecord::Base
  attr_accessible :address, :name, :ls_id
  validates :name, presence: true
  validates :address, presence: true
  
  def self.import_from_ls_page(noko_page)
    ls_id   = "1"
    name    = noko_page.css("title").text.sub(": edit your order | LivingSocial Takeout & Delivery","")
    address = noko_page.css("div.info").css("ul").css("li").last.css("p").last.text.sub(" view map","")
    create(ls_id: ls_id, name: name, address: address)
  end
end
