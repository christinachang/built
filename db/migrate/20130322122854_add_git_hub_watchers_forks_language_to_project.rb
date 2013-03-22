class AddGitHubWatchersForksLanguageToProject < ActiveRecord::Migration
  def change
    add_column :projects, :watchers, :integer
    add_column :projects, :forks, :integer
    add_column :projects, :language, :string
  end
end
