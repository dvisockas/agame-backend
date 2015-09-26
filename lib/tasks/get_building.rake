require 'json'

namespace :get_buildings do
  task run: :environment do
    Estate.delete_all

    bbox = '20.9568,55.6059,21.4735,55.7831'
    bbox_sm = '21.14134,55.69456,21.14941,55.69733'

    resp = HTTParty.get "http://overpass-api.de/api/xapi?way[bbox=#{bbox}][building=*][@meta]"
    doc = JSON.parse(Hash.from_xml(resp).to_json).with_indifferent_access

    doc[:osm][:node].each do |_node|
      estate = Estate.new
      estate.map_id = _node[:id]
      estate.latitude = _node[:lat]
      estate.longitude = _node[:lon]
      estate.save
    end

  end
end