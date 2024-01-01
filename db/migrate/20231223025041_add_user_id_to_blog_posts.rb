class AddUserIdToBlogPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :blog_posts, :user_id, :string
    add_column :blog_posts, :integer, :string
  end
end
