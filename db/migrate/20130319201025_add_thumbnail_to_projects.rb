class AddThumbnailToProjects < ActiveRecord::Migration

  def self.down
    remove_attachment :projects, :thumbnail
  end
end