class AddSemesterIDtoProjectAndUserTable < ActiveRecord::Migration
  def up
    add_column :projects, :semester_id, :string
    add_column :users, :semester_id, :string
  end

  def down
    remove_column :projects, :semester_id
    remove_column :users, :semester_id
  end
end
