class Attachment < ActiveRecord::Base
  belongs_to :user
  belongs_to :attachmentable, polymorphic: true

  mount_uploader :attachment, AttachmentUploader
end