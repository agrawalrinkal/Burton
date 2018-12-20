class BookmarksController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_bookmark, only: [:show, :update, :destroy]

  # GET /bookmarks
  # GET /bookmarks.json
  def index
    @bookmarks = Bookmark.where(:book_id => params[:book_id])

    render json: @bookmarks
  end

  # GET /bookmarks/1
  # GET /bookmarks/1.json
  def show
    render json: @bookmark
  end

  # POST /bookmarks
  # POST /bookmarks.json
  def create
    @bookmark = Bookmark.new(complete_params)

    if @bookmark.save
      render json: @bookmark #, status: :created, location: @bookmark
    else
      render json: @bookmark.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bookmarks/1
  # PATCH/PUT /bookmarks/1.json
  def update
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.update(bookmark_params)
      head :no_content
    else
      render json: @bookmark.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def destroy
    @bookmark.destroy

    head :no_content
  end

  private

    def set_bookmark
      @bookmark = Bookmark.find(params[:id])
    end

    def bookmark_params
      params
      params.permit(:book_id, :ref, :snippet)
    end

    def complete_params
      params = {
          user_id: current_user.id,
          book_id: bookmark_params[:book_id],
          ref: bookmark_params[:ref],
          snippet: bookmark_params[:snippet]
      }
      params
    end
end
