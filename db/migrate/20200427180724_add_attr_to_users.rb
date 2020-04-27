class AddAttrToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :handle, :string
    add_column :users, :question_1, :text
    add_column :users, :question_2, :text
    add_column :users, :question_3, :text
    add_column :users, :gender, :string
    add_column :users, :city, :string
    add_column :users, :lat, :float
    add_column :users, :lngt, :float
    add_column :users, :handle_visible, :boolean
    add_column :users, :profile_pic_visible, :boolean
    add_column :users, :location_visible, :boolean
  end
end
