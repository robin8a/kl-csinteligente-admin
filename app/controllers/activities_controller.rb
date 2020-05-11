class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  # GET /activities
  # GET /activities.json
  def index
    @activities = Project.find(params[:project_id]).activities.order(:id)
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
    @project = Project.find(params[:project_id])
    @user = User.find(params[:user_id])
    1.times {@activity.baselines.build}
  end

  # GET /activities/1/edit
  def edit
    @user = User.find(params[:user_id])
    @project = Project.find(params[:project_id])
    @activity = Activity.find(params[:id])
  end

  # POST /activities
  # POST /activities.json
  def create
    
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save!
        format.html { redirect_to user_project_activity_path(params[:user_id], params[:project_id], @activity), notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to user_project_activities_url, notice: 'Activity was successfully destroyed.' } 
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:ac_numbered_list, :ac_name, :ac_start_date, :ac_end_date, :activity_id,
        baselines_attributes: [:id, :project_id, :measure_id, :ba_status, :ba_type, :ba_amount, :ba_price])
    end
end
