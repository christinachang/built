class FixUrlToLiveUrlInProjects < ActiveRecord::Migration
  def up
    rename_column :projects, :url, :live_url
  end

  def down
  end
end
