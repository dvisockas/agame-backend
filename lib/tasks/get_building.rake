require 'json'

namespace :get_buildings do
  task run: :environment do
    Estate.delete_all

    bbox = '20.9568,55.6059,21.4735,55.7831'
    bbox_sm = '21.1284,55.7023,21.1607,55.7133'

    p 'downloading...'
    resp = HTTParty.get "http://overpass-api.de/api/xapi?way[bbox=#{bbox_sm}][building=*][@meta]"
    p 'parsing...'
    doc = JSON.parse(Hash.from_xml(resp).to_json).with_indifferent_access
    p 'looking up unique keys...'
    ids = doc[:osm][:node].map{|d|d[:changeset]}.uniq
    p 'importing...'
    ids.each do |id|
      nodes = doc[:osm][:node].select{ |d| d[:changeset]. == id }
      latitude = nodes.sum{ |l| l[:lat].to_f } / nodes.count
      longitude = nodes.sum{ |l| l[:lon].to_f } / nodes.count

      estate = Estate.new
      estate.map_id = nodes.first[:id]
      estate.latitude = nodes.first[:lat]
      estate.longitude = nodes.first[:lon]
      estate.save
    end

  end
end