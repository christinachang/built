class CreateInnerJoinTable < ActiveRecord::Migration
  def change
    create_table :project_collaborators, :id => false do |t|
      t.references :project, :null => false
      t.references :collaborator, :null => false
    end
  end
  def down
    create_table :project_collaborators, :id => false do |t|
        t.references :project, :null => false
        t.references :collaborator, :null => false
    end
  end
end
