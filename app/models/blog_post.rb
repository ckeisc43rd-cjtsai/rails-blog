class BlogPost < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  belongs_to :user
  has_many :comments
  acts_as_taggable_on :tags  # This makes the model taggable
end
