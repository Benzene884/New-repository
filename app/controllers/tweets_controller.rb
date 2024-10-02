class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[show edit update destroy]

  def index
    @tweets = Tweet.all.order(created_at: :desc)
  end

  def show; end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.tdate = Time.current

    if @tweet.save
      flash[:notice] = "ツイートを作成しました"
      redirect_to @tweet
    else
      flash.now[:alert] = "メッセージは1文字以上、140文字以下にしてください"
      render :new
    end
  end

  def edit; end

  def update
    if @tweet.update(tweet_params)
      flash[:notice] = "ツイートを更新しました"
      redirect_to @tweet
    else
      flash.now[:alert] = "メッセージは1文字以上、140文字以下にしてください"
      render :edit
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    if @tweet.destroy
      flash[:notice] = "ツイートが削除されました"
      redirect_to tweets_path
    else
      flash[:alert] = "ツイートの削除に失敗しました"
      redirect_to tweet_path(@tweet)
    end
  rescue => e
    logger.error "Error deleting tweet: #{e.message}"
    flash[:alert] = "エラーが発生しました: #{e.message}"
    redirect_to tweets_path
  end


  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:message)
  end
end
