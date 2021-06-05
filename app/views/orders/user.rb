class User < ApplicationRecord
  has_and_belongs_to_many :forums
  has_one :profile
end 
