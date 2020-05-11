class QaqcsController < ApplicationController
  before_action :set_qaqc, only: [:show, :edit, :update, :destroy]

  # GET /qaqcs
  # GET /qaqcs.json
  def index
    @qaqcs = Qaqc.all
  end

  # GET /qaqcs/1
  # GET /qaqcs/1.json
  def show
  end

  # GET /qaqcs/new
  def new
    @qaqc = Qaqc.new
  end

  # GET /qaqcs/1/edit
  def edit
  end

  # POST /qaqcs
  # POST /qaqcs.json
  def create
    @qaqc = Qaqc.new(qaqc_params)

    respond_to do |format|
      if @qaqc.save
        format.html { redirect_to @qaqc, notice: 'Qaqc was successfully created.' }
        format.json { render :show, status: :created, location: @qaqc }
      else
        format.html { render :new }
        format.json { render json: @qaqc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /qaqcs/1
  # PATCH/PUT /qaqcs/1.json
  def update
    respond_to do |format|
      if @qaqc.update(qaqc_params)
        format.html { redirect_to @qaqc, notice: 'Qaqc was successfully updated.' }
        format.json { render :show, status: :ok, location: @qaqc }
      else
        format.html { render :edit }
        format.json { render json: @qaqc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qaqcs/1
  # DELETE /qaqcs/1.json
  def destroy
    @qaqc.destroy
    respond_to do |format|
      format.html { redirect_to qaqcs_url, notice: 'Qaqc was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qaqc
      @qaqc = Qaqc.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def qaqc_params
      params.require(:qaqc).permit(:qa_name)
    end
end
