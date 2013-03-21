class AddGithubHtmlUrlToUser < ActiveRecord::Migration
  def change
    add_column :users, :github_html_url, :string
  end
end
