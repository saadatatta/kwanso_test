class BlogSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :description, :user_id, :images

  def images
    object.images.map(&:service_url)
  end
end
