require 'json'

namespace :get_buildings do
  task run: :environment do

    bbox = '20.9568,55.6059,21.4735,55.7831'
    bbox_sm = '21.1284,55.7023,21.1607,55.7133'
    # "http://overpass-api.de/api/xapi?way[bbox=21.1284,55.7023,21.1607,55.7133][building=yes]"

    p 'downloading...'
    # resp = HTTParty.get "http://overpass-api.de/api/xapi?way[bbox=#{bbox_sm}][building=yes]"
    resp = File.open(Rails.root.to_s + '/lib/tasks/xapi').read
    p 'parsing...'
    doc = JSON.parse(Hash.from_xml(resp).to_json).with_indifferent_access
    p 'importing...'
    doc[:osm][:way].each do |way|
      @tags = way[:tag]
      next if tget('building') != 'yes'

      nodes = doc[:osm][:node].select{ |n| n[:id].in? way[:nd].map{ |nd| nd.values[0] } }
      latitude, longitude = Geocoder::Calculations.geographic_center nodes.map{ |n| [ n[:lat], n[:lon] ] }

      estate = Estate.find_or_initialize_by map_id: way[:id]
      estate.latitude = latitude
      estate.longitude = longitude
      estate.name = tget('name') || ( (tget('addr:street') || 'Whoosh') + (tget('addr:housenumber') || '') )
      estate.area = 0#calculate_area nodes.map{ |n| [ n[:lat], n[:lon] ] }
      estate.save

    end

  end

  def tget selector
    if @tags.class == Array
      tag = @tags.select{ |h| h[:k] == selector }.first
      tag.try(:keys) and tag[:v]
    else
      tag = (@tags[:k] == selector ? tag : nil)
      tag.try(:keys) and tag[:v]
    end
  end

  def calculate_area points
    area = 0
    j = points.count - 1

    points.each_with_index do |p, i|
      area += (points[j][0] + p[0]) * (points[j][1] - p[1])
      j = i
    end

    area / 2
  end

end