class AddAuthorToBlogPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :blog_posts, :author, :integer
  end
end
