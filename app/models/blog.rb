class Blog < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates_presence_of :title, :description
  
end
