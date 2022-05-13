module BxBlockContentManagement
  class Video < ApplicationRecord
    self.table_name = :videos
    mount_uploader :video, VideoUploader

    # Associations
    belongs_to :attached_item, polymorphic: true

    # Validations
    validates_presence_of :video
  end
end
