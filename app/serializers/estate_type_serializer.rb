class EstateTypeSerializer < ActiveModel::Serializer

  attributes :id, :kind, :name, :level
  attributes :health, :health_regen, :cost, :build_time

  %w( health cost health_regen build_time ).each do |_name|
    define_method "#{_name}" do
      if options[:estate].present?
        ( options[:estate].send "calculated_#{_name}" ) * object.send(_name)
      else
        object.send(_name)
      end
    end
  end

end