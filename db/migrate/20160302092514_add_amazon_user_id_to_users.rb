class AddAmazonUserIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :amazon_user_id, :string
  end
end
