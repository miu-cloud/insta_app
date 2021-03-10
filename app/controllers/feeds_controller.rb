class FeedsController < ApplicationController
  before_action :logged_in?, only:[:new,:create]
  before_action :set_feed, only: %i[ show edit update destroy ]
  before_action :block_other_user, only: [:edit, :update, :destroy]

  def index
    @feeds = Feed.all
  end

  def show
    @favorite = current_user.favorites.find_by(feed_id: @feed.id)
  end

  def new
    @feed = Feed.new
  end

  def confirm
    @feed = Feed.new(feed_params)
  end
  
  def edit
  end
  
  def create
    @feed = current_user.feeds.build(feed_params)   
    respond_to do |format|
      if @feed.save
        ContactMailer.contact_mail(@feed).deliver
        format.html { redirect_to feeds_path, notice: "Feed was successfully created." }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: "Feed was successfully updated." }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: "Feed was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_feed
    @feed = Feed.find(params[:id])
  end
  def feed_params
    params.require(:feed).permit(:image, :image_cache, :text)
  end
  def block_other_user
    if current_user.id != @feed.user_id
      redirect_to feeds_path, notice:"投稿者ではありません"
    end
  end
end
