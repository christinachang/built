class DropTableCollaborators < ActiveRecord::Migration
  def up
    drop_table :collaborators
  end

  def down
    create_table :collaborators do |t|
      t.string :email
      t.string :full_name
      t.string :github_html_url
      t.string :github_login
    end
  end
end
