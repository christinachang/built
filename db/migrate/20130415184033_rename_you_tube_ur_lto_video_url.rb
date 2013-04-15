class RenameYouTubeUrLtoVideoUrl < ActiveRecord::Migration
  def change
    rename_column :projects, :youtube_url, :video_url
  end
end
