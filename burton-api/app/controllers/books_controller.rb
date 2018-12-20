class BooksController < ApplicationController
  before_filter :process_params, only: [:create, :update]
  before_action :set_book, only: [:show, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all

    render json: @books
  end

  # GET /books/1
  # GET /books/1.json
  def show
    render json: @book
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(complete_params)

    if @book.save
      # Process ePub
      EpubProcessJob.perform_later @book
      # Render Success
      render json: @book, status: :created
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      head :no_content
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy

    head :no_content
  end

  private

    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.permit(:title, :description, :epub)
    end

    def complete_params
      params = {
          user_id: current_user.id,
          title: book_params[:title],
          description: book_params[:description],
          epub: book_params[:epub],
          uuid: SecureRandom.uuid
      }
      params
    end

    def process_params
      if params[:file]
        params[:epub] = params[:file]
      end
    end

end
