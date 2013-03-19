class AddAttachmentThumbnailrToProjects < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.attachment :thumbnail
    end
  end

  def self.down
    drop_attached_file :projects, :thumbnail
  end
end
