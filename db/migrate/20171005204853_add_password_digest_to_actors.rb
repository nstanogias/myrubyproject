class AddPasswordDigestToActors < ActiveRecord::Migration[5.1]
  def change
    add_column :actors, :password_digest, :string
  end
end
