class CreateTweets < ActiveRecord::Migration[7.0]
  def change
    create_table :tweets do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :twitter_account, null: false, foreign_key: true
      t.datetime :publish_at
      t.string :tweet_id
      t.string :body
      
      t.timestamps
    end
  end
end
