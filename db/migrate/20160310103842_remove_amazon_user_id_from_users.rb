class RemoveAmazonUserIdFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :amazon_user_id, :string
  end
end
