class CreateResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :responses do |t|
      t.integer :to_user_id
      t.integer :from_user_id
      t.boolean :accepted
      t.text :answer_1
      t.text :answer_2
      t.text :answer_3

      t.timestamps
    end
  end
end
