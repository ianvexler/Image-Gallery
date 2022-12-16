class Gallery < ApplicationRecord
  belongs_to :user

  has_many :images, dependent: :destroy

  validates :title, presence: true 
end
