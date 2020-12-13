class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.string :name
      t.text :comment_text
      t.timestamps
    end
  end
end
