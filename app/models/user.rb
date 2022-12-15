class User < ApplicationRecord
    has_many :galleries, dependent: :destroy
    
    has_secure_password
    validates :email, presence: true 
end
