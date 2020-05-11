class EnterprisesController < ApplicationController
  before_action :set_enterprise, only: [:show, :edit, :update, :destroy]
  before_action :verify_is_admin

  # GET /enterprises
  # GET /enterprises.json
  def index
    @enterprises = CsUser.find(params[:cs_user_id]).enterprises
  end

  # GET /enterprises/1
  # GET /enterprises/1.json
  def show
  end

  # GET /enterprises/new
  def new
    @enterprise = Enterprise.new
    @cs_user = CsUser.find(params[:cs_user_id])
  end

  # GET /enterprises/1/edit
  def edit
    @enterprise = Enterprise.find(params[:id])
    @cs_user = CsUser.find(params[:cs_user_id])
  end

  # POST /enterprises
  # POST /enterprises.json
  def create
    @enterprise = Enterprise.new(enterprise_params)

    respond_to do |format|
      if @enterprise.save
        format.html { redirect_to cs_user_enterprise_path(params[:cs_user_id], @enterprise), notice: 'Enterprise was successfully created.' }
        format.json { render :show, status: :created, location: @enterprise }
      else
        format.html { render :new }
        format.json { render json: @enterprise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enterprises/1
  # PATCH/PUT /enterprises/1.json
  def update
    respond_to do |format|
      if @enterprise.update(enterprise_params)
        format.html { redirect_to cs_user_enterprise_path(params[:cs_user_id], @enterprise), notice: 'Enterprise was successfully updated.' }
        format.json { render :show, status: :ok, location: @enterprise }
      else
        format.html { render :edit }
        format.json { render json: @enterprise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enterprises/1
  # DELETE /enterprises/1.json
  def destroy
    @enterprise.destroy
    respond_to do |format|
      format.html { redirect_to enterprises_url, notice: 'Enterprise was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def verify_is_admin
    if !is_admin?
      flash[:danger] = "Unauthorized access"
      # redirect_to(root_url)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enterprise
      @enterprise = Enterprise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enterprise_params
      params.require(:enterprise).permit(:en_name)
    end
end
