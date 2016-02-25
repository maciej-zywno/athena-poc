class AddAthenaProviderIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :athena_provider_id, :integer
  end
end
