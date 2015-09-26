require 'nokogiri'

namespace :get_buildings do
  task run: :environment do

    resp = HTTParty.get 'http://overpass-api.de/api/xapi?way[bbox=20.9568,55.6059,21.4735,55.7831][building=*][@meta]'
    doc = Nokogiri::XML resp
    doc.xpath('//node').each do |thing|
      byebug
    end

  end
end