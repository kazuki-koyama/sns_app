class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :before_image_id
      t.string :after_image_id
      t.text :caption

      t.timestamps
    end
  end
end
