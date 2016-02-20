class SnippetsController < ApplicationController
  before_action :find_snippet, only: [:show, :edit, :update]
  def new
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new snippet_params
    if @snippet.save
      redirect_to snippet_path(@snippet), notice: "Snippet created"
    else
      flash[:alert] = "Error: Snippet was not created"
      render :new
    end
  end

  def show
    render :show
  end

  def index
    @snippets = Snippet.all
  end

  def edit
    render :edit
  end

  def update
    if @snippet.update snippet_params
      redirect_to snippet_path(@snippet), notice: "Snippet Updated!"
    else
      flash[:alert] = "Error: Snippet was not updated!"
      render :edit
    end
  end

  private

  def snippet_params
    params.require(:snippet).permit(:title, :work)
  end

  def find_snippet
    @snippet = Snippet.find  params[:id]
  end

end
