class AddActorIdToMovies < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :actor_id, :integer
  end
end
