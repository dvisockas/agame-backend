class EstateTypeSerializer < ActiveModel::Serializer

  attributes :id, :kind, :name, :level
  attributes :health, :health_regen, :cost, :build_time, :resource_rate

  %w( health cost health_regen build_time resource_rate ).each do |_name|
    define_method "#{_name}" do
      if options[:estate].present?
        ( ( options[:estate].send "calculated_#{_name}" ) * object.send(_name) ).round 0
      else
        object.send(_name).round 0
      end
    end
  end

end