class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :description
      t.integer :user_id
      t.integer :movie_id
    end
  end
end
