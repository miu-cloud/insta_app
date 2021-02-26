class Feed < ApplicationRecord
    mount_uploader :image, ImageUploader
    validates :image, presence: true
    validates :text, presence: true
    belongs_to :user
end
