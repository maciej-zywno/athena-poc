class AddAthenaIdAndAthenaSecretToUsers < ActiveRecord::Migration
  def change
    add_column :users, :athena_id, :string
    add_column :users, :athena_secret, :string
  end
end
