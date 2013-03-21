class RemoveFullNameFromProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :full_name
  end

  def down
    add_column :projects, :fullname
  end
end
