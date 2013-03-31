class RemoveColsFromProjects < ActiveRecord::Migration
  def up
    drop_table :cover_photos
  end

  def down
    create_table :cover_photos do |t|
    t.integer  "project_id"
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
  end
end
