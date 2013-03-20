class AddSshUrlToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :ssh_url, :string
  end
end
