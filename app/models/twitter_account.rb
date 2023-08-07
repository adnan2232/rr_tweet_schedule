

class TwitterAccount < ApplicationRecord
  belongs_to :user
  has_many :tweets
  #validates :username, uniqueness: true
  #validates :username, uniqueness: true

  def client
    puts secret
    Twitter::REST::Client.new(
      consumer_key: Rails.application.credentials.dig(:twitter,:api_key),
      consumer_secret: Rails.application.credentials.dig(:twitter,:api_secret),
      access_token: token,
      access_token_secret: secret 
    )
  end
end
