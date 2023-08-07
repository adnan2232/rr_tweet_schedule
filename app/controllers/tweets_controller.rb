class TweetsController < ApplicationController
    before_action :require_user_logged_in!, :has_any_twitter_account!
    before_action :set_tweet, only:[:edit, :update, :destroy]
    def index
        @tweets = Current.user.tweets
    end

    def new
        @tweet = Tweet.new
    end

    def create
        @tweet = Current.user.tweets.new(tweet_params)
        if @tweet.save
            redirect_to tweets_path, notice: "Tweet scheduled successfully"
        else
            render :new, alert: "Something went wrong"
        end
    end

    def edit

    end

    def update
        
        if @tweet.update(tweet_params)
            redirect_to tweets_path, notice: "Tweet edited successfully"
        else
            render :edit, alert: "Something went wrong"
        end

    end

    def destroy
        if @tweet.destroy
            redirect_to tweets_path, notice: "Tweet deleted successfully"
        else
            render :index, alert: "Unable to delete the tweet"
        end
    end
    private 
    def has_any_twitter_account!
        redirect_to root_path, alert: "No twitter account linked" if Current.user && !Current.user.twitter_accounts.any?
    end

    def tweet_params

        params.require(:tweet).permit(:twitter_account_id,:body, :publish_at)
    end

    def set_tweet
        @tweet = Current.user.tweets.find(params[:id])
    end
end
