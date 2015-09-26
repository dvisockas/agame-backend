class EstateTypeSerializer < ActiveModel::Serializer

  attributes :id, :kind, :name, :level, :cost, :health, :build_time

end