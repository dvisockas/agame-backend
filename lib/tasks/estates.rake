require 'json'

namespace :estates do
  task run: :environment do

    hackathon = '21.1284,55.7023,21.1607,55.7133'
    vilnius = '25.300076007843018,54.68982105408392,25.327134132385254,54.70118023682463'

    # url = "https://www.openstreetmap.org/api/0.6/map?bbox=#{bbox_sm}"
    # url = "http://overpass-api.de/api/xapi?way[bbox=#{vilnius}][building=*][@meta]"

    p 'downloading...'
    # resp = (HTTParty.get url).body
    resp = File.open(Rails.root.to_s + '/lib/tasks/vilnius').read
    p 'parsing...'
    doc = JSON.parse(Hash.from_xml(resp).to_json).with_indifferent_access
    p 'importing...'
    doc[:osm][:way].each do |way|
      @tags = way[:tag]

      nodes = doc[:osm][:node].select{ |n| n[:id].in? way[:nd].map{ |nd| nd.values[0] } }
      latitude, longitude = Geocoder::Calculations.geographic_center nodes.map{ |n| [ n[:lat], n[:lon] ] }

      estate = Estate.find_or_initialize_by map_id: way[:id]
      estate.latitude = latitude
      estate.longitude = longitude
      estate.name = tget('name') || ( (tget('addr:street') || 'Whoosh') + (tget('addr:housenumber') || '') )
      estate.area = calculate_area nodes.map{ |n| [ n[:lat], n[:lon] ] }
      estate.save

      way[:nd].each_with_index do |nd, index|
        node = doc[:osm][:node].select{ |n| n[:id] == nd[:ref] }.first
        estate.nodes.find_or_create_by({ latitude: node[:lat], longitude: node[:lon], position: index })
      end

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
      plot = (points[j][0].to_f + p[0].to_f) * (points[j][1].to_f - p[1].to_f)
      plot = (plot > 0) ? plot * 10 : (plot * -1) * 100
      area += plot
    end

    area / 2
  end

end