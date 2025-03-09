# app/models/problem.rb
class Problem < ApplicationRecord
    validates :name, presence: true
    validates :url, presence: true, format: { with: URI::regexp(%w[http https]), message: "must be a valid URL" }
    validates :category, presence: true
    has_many :user_problems
    has_many :users, through: :user_problems
end
  