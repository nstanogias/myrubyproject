class Add < ActiveRecord::Migration[5.1]
  def change
    remove_column :movies, :actor_id, :integer
    add_column :movies, :user_id, :integer
  end
end
