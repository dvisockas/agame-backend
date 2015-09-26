class ApplicationController < ActionController::API
  include ActionController::Serialization

  def default_serializer_options(options={})
    options.merge({root: 'data'})
  end
end
