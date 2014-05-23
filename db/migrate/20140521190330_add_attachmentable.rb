class AddAttachmentable < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :attachmentable, polymorphic: true, index: true
      t.references :user, index: true
    end
  end
end
