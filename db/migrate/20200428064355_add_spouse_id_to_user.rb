class AddSpouseIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :spouse_id, :integer
  end
end
