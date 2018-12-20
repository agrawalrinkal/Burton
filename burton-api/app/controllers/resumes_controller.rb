class ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resume, only: [:show, :update, :destroy]

  # GET /resumes
  # GET /resumes.json
  def index
    @resumes = Resume.where(:book_id => params[:book_id])

    render json: @resumes
  end

  # GET /resumes/1
  # GET /resumes/1.json
  def show
    render json: @resume
  end

  # POST /resumes
  # POST /resumes.json
  def create
    @resume = Resume.new(complete_params)

    if @resume.save
      render json: @resume, status: :created, location: @resume
    else
      render json: @resume.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /resumes/1
  # PATCH/PUT /resumes/1.json
  def update
    @resume = Resume.find(params[:id])

    if @resume.update(resume_params)
      head :no_content
    else
      render json: @resume.errors, status: :unprocessable_entity
    end
  end

  # DELETE /resumes/1
  # DELETE /resumes/1.json
  def destroy
    @resume.destroy

    head :no_content
  end

  private

    def set_resume
      @resume = Resume.find(params[:id])
    end

    def resume_params
      params.permit(:book_id, :spine_position, :styles)
    end

    def complete_params
      params = {
          user_id: current_user.id,
          book_id: resume_params[:book_id],
          spine_position: resume_params[:spine_position],
          styles: resume_params[:styles]
      }
      params
    end

end
