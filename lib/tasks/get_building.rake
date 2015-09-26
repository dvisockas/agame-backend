require 'json'

namespace :get_buildings do
  task run: :environment do
    Estate.delete_all

    bbox = '20.9568,55.6059,21.4735,55.7831'
    bbox_sm = '21.1284,55.7023,21.1607,55.7133'

    p 'downloading...'
    resp = HTTParty.get "http://overpass-api.de/api/xapi?way[bbox=#{bbox_sm}][building=yes]"
    p 'parsing...'
    doc = JSON.parse(Hash.from_xml(resp).to_json).with_indifferent_access
    p 'importing...'
    doc[:osm][:node].each do |node|
      estate = Estate.new
      estate.map_id = node[:id]
      estate.latitude = node[:lat]
      estate.longitude = node[:lon]
      estate.save
    end

  end
end