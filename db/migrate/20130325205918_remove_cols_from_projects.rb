class RemoveColsFromProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :github_link
    rename_column :projects, :url, :live_url
  end

  def down
    add_column :projects, :github_link, :string
    rename_column :projects, :live_url, :url
  end
end
