require 'json'

namespace :get_buildings do
  task run: :environment do
    Estate.delete_all

    bbox = '20.9568,55.6059,21.4735,55.7831'
    bbox_sm = '21.1284,55.7023,21.1607,55.7133'
    # "http://overpass-api.de/api/xapi?way[bbox=21.1284,55.7023,21.1607,55.7133][building=yes]"

    p 'downloading...'
    resp = HTTParty.get "http://overpass-api.de/api/xapi?way[bbox=#{bbox_sm}][building=yes]"
    # resp = File.open(Rails.root.to_s + '/lib/tasks/xapi').read
    p 'parsing...'
    doc = JSON.parse(Hash.from_xml(resp).to_json).with_indifferent_access
    p 'importing...'
    doc[:osm][:way].each do |way|

      next if way[:tag].select{ |h| h[:k] == 'building' }.first[:v] != 'yes' rescue lambda { way[:tag][:k] == 'buiilding' && way[:tag][:k] != 'yes' }

      nodes = doc[:osm][:node].select{ |n| n[:id].in? way[:nd].map{ |nd| nd.values[0] } }
      latitude = nodes.sum{ |n| n[:lat].to_f } / nodes.count
      longitude = nodes.sum{ |n| n[:lon].to_f } / nodes.count

      estate = Estate.new
      estate.map_id = way[:id]
      estate.latitude = latitude
      estate.longitude = longitude
      estate.save

    end

  end
end