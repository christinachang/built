class CreateTableCoverPhotos < ActiveRecord::Migration
  def change
    create_table :cover_photos do |t|
      t.references :project
      t.attachment :upload
    end
  end
end
