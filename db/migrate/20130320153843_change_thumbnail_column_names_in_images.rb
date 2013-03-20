class ChangeThumbnailColumnNamesInImages < ActiveRecord::Migration
  def up
    change_table :images do |t|
      t.attachment :upload
    end
  end

  def down
  end
end
