class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :web_page_link
      t.string :image_link
      t.string :video_link
      t.datetime :date
      t.string :contact
      t.decimal :price

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
