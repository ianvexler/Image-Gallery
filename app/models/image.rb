class Image < ApplicationRecord
    include ImageUploader::Attachment(:image) 

    belongs_to :gallery 

    validates :image, presence: true
end
