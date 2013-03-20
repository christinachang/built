class ImagesRemoveThumbnailColumns < ActiveRecord::Migration
  def up
    remove_column :images, :thumbnail_file_name
    remove_column :images, :thumbnail_content_type
    remove_column :images, :thumbnail_file_size
    remove_column :images, :thumbnail_updated_at
  end

  def down
  end
end
