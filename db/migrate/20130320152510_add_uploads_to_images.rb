class AddUploadsToImages < ActiveRecord::Migration
def self.up
    change_table :images do |t|
      t.attachment :thumbnail
    end
  end

  def self.down
    drop_attached_file :images, :thumbnail
  end
end
