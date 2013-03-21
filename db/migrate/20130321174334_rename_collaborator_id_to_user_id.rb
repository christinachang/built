class RenameCollaboratorIdToUserId < ActiveRecord::Migration
  def up
    rename_column :project_users, :collaborator_id, :user_id
  end

  def down
    rename_column :project_users, :user_id, :collaborator_id
  end
end
