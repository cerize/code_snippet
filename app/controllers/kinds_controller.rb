class KindsController < ApplicationController

  def new
    @kind = Kind.new
    render :new
  end

  def create
    @kind = Kind.new kind_params
    if @kind.save
      redirect_to kind_path(@kind), notice: "New Kind created!"
    else
      flash[:alert] = "ERROR: Kind not created"
      render :new
    end
  end

  def show
    find_kind
    render :show
  end

  def index
    @kinds = Kind.all
    render :index
  end

  def edit
    find_kind
    render :edit
  end

  def update
    find_kind
    if @kind.update kind_params
    redirect_to kind_path(@kind), notice: "Kind updated!"
  else
    flash[:alert] = "ERROR: Kind was not updated"
    render :edit
  end

  end


  private

  def kind_params
    params.require(:kind).permit(:name)
  end

  def find_kind
    @kind = Kind.find params[:id]
  end

end
