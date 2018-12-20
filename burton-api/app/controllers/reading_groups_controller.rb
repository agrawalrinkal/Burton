class ReadingGroupsController < ApplicationController
  before_action :set_reading_group, only: [:show, :update, :destroy]

  # GET /reading_groups
  # GET /reading_groups.json
  def index
    @reading_groups = ReadingGroup.all

    render json: @reading_groups
  end

  # GET /reading_groups/1
  # GET /reading_groups/1.json
  def show
    render json: @reading_group
  end

  # POST /reading_groups
  # POST /reading_groups.json
  def create
    @reading_group = ReadingGroup.new(reading_group_params)

    if @reading_group.save
      render json: @reading_group, status: :created, location: @reading_group
    else
      render json: @reading_group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reading_groups/1
  # PATCH/PUT /reading_groups/1.json
  def update
    @reading_group = ReadingGroup.find(params[:id])

    if @reading_group.update(reading_group_params)
      head :no_content
    else
      render json: @reading_group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reading_groups/1
  # DELETE /reading_groups/1.json
  def destroy
    @reading_group.destroy

    head :no_content
  end

  private

    def set_reading_group
      @reading_group = ReadingGroup.find(params[:id])
    end

    def reading_group_params
      params[:reading_group]
    end
end
