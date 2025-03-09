class CreateUserProblems < ActiveRecord::Migration[7.1]
  def change
    create_table :user_problems do |t|
      t.references :user, null: false, foreign_key: true
      t.references :problem, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
