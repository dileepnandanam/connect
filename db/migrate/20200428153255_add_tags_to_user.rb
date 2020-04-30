class AddTagsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tags, :text, default: ''
    add_column :users, :facebook_link, :text, default: ''
  end
end
