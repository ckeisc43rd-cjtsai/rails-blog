class AddBlogPostIdToComment < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :user_id, :string
    add_column :comments, :blog_post_id, :string
  end
end
