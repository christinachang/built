class DropTableProjectCollaborators < ActiveRecord::Migration
   def up
    drop_table :project_collaborators
  end

  def down
    create_table :project_collaborators do |t|
      t.string :project_id
      t.string :collaborator_id
    end
  end
end
