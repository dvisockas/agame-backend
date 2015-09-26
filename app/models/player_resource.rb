class PlayerResource < ActiveRecord::Base

  enum kind: [:gold]

end