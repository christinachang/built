class FixUrlToLiveUrlInProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :url
    add_column :projects, :live_url, :string
  end
end
