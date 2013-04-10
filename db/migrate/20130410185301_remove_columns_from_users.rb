class RemoveColumnsFromUsers < ActiveRecord::Migration
  def up
    remove_columns(:users, :profile_image_file_name, :profile_image_content_type, :profile_image_file_size, :profile_image_updated_at)
  end
end

