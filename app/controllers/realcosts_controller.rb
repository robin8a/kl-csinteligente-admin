class RealcostsController < ApplicationController
  before_action :set_realcost, only: [:show, :edit, :update, :destroy]

  # GET /realcosts
  # GET /realcosts.json
  def index
    @realcosts = Realcost.all
  end

  # GET /realcosts/1
  # GET /realcosts/1.json
  def show
  end

  # GET /realcosts/new
  def new
    @realcost = Realcost.new
  end

  # GET /realcosts/1/edit
  def edit
  end

  # POST /realcosts
  # POST /realcosts.json
  def create
    @realcost = Realcost.new(realcost_params)

    respond_to do |format|
      if @realcost.save
        format.html { redirect_to @realcost, notice: 'Realcost was successfully created.' }
        format.json { render :show, status: :created, location: @realcost }
      else
        format.html { render :new }
        format.json { render json: @realcost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /realcosts/1
  # PATCH/PUT /realcosts/1.json
  def update
    respond_to do |format|
      if @realcost.update(realcost_params)
        format.html { redirect_to @realcost, notice: 'Realcost was successfully updated.' }
        format.json { render :show, status: :ok, location: @realcost }
      else
        format.html { render :edit }
        format.json { render json: @realcost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /realcosts/1
  # DELETE /realcosts/1.json
  def destroy
    @realcost.destroy
    respond_to do |format|
      format.html { redirect_to realcosts_url, notice: 'Realcost was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_realcost
      @realcost = Realcost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def realcost_params
      params.require(:realcost).permit(:re_date, :re_value, :project_id)
    end
end
