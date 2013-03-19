class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :subtitle
      t.text :description
      t.string :url
      t.string :github_link

      t.timestamps
    end
  end
end
