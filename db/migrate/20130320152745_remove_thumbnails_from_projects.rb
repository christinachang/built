class RemoveThumbnailsFromProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :thumbnail_file_name
    remove_column :projects, :thumbnail_content_type
    remove_column :projects, :thumbnail_file_size
    remove_column :projects, :thumbnail_updated_at
  end

  def down
  end
end
