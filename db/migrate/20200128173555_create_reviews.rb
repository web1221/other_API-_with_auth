class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :body_text
      t.integer :rating
      t.integer :destination_id

      t.timestamps
    end
  end
end
