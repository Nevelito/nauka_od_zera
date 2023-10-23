class AddUserIdToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :user_id, :integer
    change_column :articles, :user_id, :bigint, null: false
  end
end
