class Team < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  has_many :users
  has_many :achievements
  has_one :admin, class_name: "User"
end
