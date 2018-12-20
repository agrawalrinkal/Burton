class AnnotationsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_annotation, only: [:show, :update, :destroy]

  # GET /annotations
  # GET /annotations.json
  def index
    @annotations = Annotation.all

    render json: @annotations
  end

  def search
    if params[:book_id] && params[:base_uri]
      @annotations = Annotation.where(book_id: params[:book_id], base_uri: params[:base_uri])
    else
      @annotations = Annotation.all
    end
    rows = {}
    rows[:rows] = @annotations
    render json: rows
  end

  # GET /annotations/1
  # GET /annotations/1.json
  def show
    render json: @annotation
  end

  # POST /annotations
  # POST /annotations.json
  def create
    @annotation = Annotation.new(complete_params)

    if @annotation.save
      render json: @annotation, status: :created #, location: @annotation
    else
      render json: @annotation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /annotations/1
  # PATCH/PUT /annotations/1.json
  def update
    @annotation = Annotation.find(params[:id])

    if @annotation.update(annotation_params)
      head :no_content
    else
      render json: @annotation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /annotations/1
  # DELETE /annotations/1.json
  def destroy
    @annotation.destroy

    head :no_content
  end

  private

    def set_annotation
      @annotation = Annotation.find(params[:id])
    end

    def annotation_params
      params.permit(:quote, :book_id, :base_uri, :text, :format, ranges: [:start, :startOffset, :end, :endOffset])
    end

    def complete_params
      params = {
          user_id: current_user.id,
          book_id: annotation_params[:book_id],
          base_uri: annotation_params[:base_uri],
          quote: annotation_params[:quote],
          ranges: annotation_params[:ranges],
          text: annotation_params[:text]
      }
      params
    end

end
