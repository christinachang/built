class RemoveSubtitleFromProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :subtitle
  end

  def down
    add_column :projects, :subtitle, :string
  end
end
