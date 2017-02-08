class AddUserIdToArticles < ActiveRecord::Migration[5.0]
  def change
    add_reference :articles, :user, index: true, foreign_key: true
    add_foreign_key :articles, :users
  end
end
