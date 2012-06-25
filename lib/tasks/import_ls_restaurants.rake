require 'open-uri'

namespace :import do
  desc "imports LS Takeout & Delivery restaurants from LS site"
  task :restaurants => :environment do
    page_count = 1
    have_results = true
    while (page_count <= 40 && have_results)
      puts "scraping LS page #{page_count}"
      doc = Nokogiri::HTML(open("https://livingsocial.com/menus/city/36-washington-d-c?mode=takeout&page=#{page_count}"))
      unless doc.css("div.no-search-results").empty?
        have_results = false
      else
        doc.css("div.location-info-mini").each do |div|
          ls_id = div.css("a").first["href"][/\d+/]
          show_page = Nokogiri::HTML(open("https://livingsocial.com/menus/locations/#{ls_id}/order/edit?mode=takeout"))
          Restaurant.import_from_ls_page show_page, ls_id
        end  
      end
      page_count += 1
    end
  end
end