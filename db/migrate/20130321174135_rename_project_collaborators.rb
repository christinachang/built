class RenameProjectCollaborators < ActiveRecord::Migration
  def up
    rename_table :project_collaborators, :project_users
  end

  def down
    rename_table :project_users, :project_collaborators
  end
end


