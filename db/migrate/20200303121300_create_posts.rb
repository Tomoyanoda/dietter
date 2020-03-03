class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.float :weight
      t.string :image

      t.timestamps
    end
  end
end
