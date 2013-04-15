class AddColumnToProjectsTable < ActiveRecord::Migration
  def change
    add_column :projects, :last_repo_update, :string
  end
end
