class Team < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  has_many :users
end
