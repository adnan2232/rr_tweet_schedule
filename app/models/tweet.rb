require 'oauth/request_proxy/typhoeus_request'
class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_account

  validates :body, length: {minimum:1,maximum:200}
  validates :publish_at, presence: true
  validate :verify_publish_at?

  def verify_publish_at?
    return self.publish_at.after? 1.minutes.from_now
  end

  def published?

    self.tweet_id?
  end
  

  after_initialize do
    self.publish_at ||= 24.hours.from_now
  end

  def publish_to_twitter!
    options = {
	    method: :post,
      headers: {
        "User-Agent": "v2CreateTweetRuby",
        "content-type": "application/json"
      },
      body: JSON.dump({"text":body})
    }
    url = "https://api.twitter.com/2/tweets"

    consumer = OAuth::Consumer.new(
      Rails.application.credentials.dig(:twitter,:api_key),
      Rails.application.credentials.dig(:twitter,:api_secret),
      :site => 'https://api.twitter.com',
      :authorize_path => '/oauth/authenticate',
      :debug_output => false
    )

    access_token = OAuth::Token.new(
      twitter_account.token,
      twitter_account.secret
    )
    oauth_params = {:consumer => consumer, :token => access_token}

    request = Typhoeus::Request.new(url, options)
	  oauth_helper = OAuth::Client::Helper.new(request, oauth_params.merge(:request_uri => url))
	  request.options[:headers].merge!({"Authorization" => oauth_helper.header}) # Signs the request
    p request
	  response = request.run

    result = JSON.parse(response.body)

    update(tweet_id: result["data"]["id"])
    
  end
end
