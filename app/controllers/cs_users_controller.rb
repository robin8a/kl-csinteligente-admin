class CsUsersController < ApplicationController
  before_action :set_cs_user, only: [:show, :edit, :update, :destroy]

  # GET /cs_users
  # GET /cs_users.json
  def index
    @cs_users = CsUser.all
  end

  # GET /cs_users/1
  # GET /cs_users/1.json
  def show
  end

  # GET /cs_users/new
  def new
    @cs_user = CsUser.new
  end

  # GET /cs_users/1/edit
  def edit
  end

  # POST /cs_users
  # POST /cs_users.json
  def create
    @cs_user = CsUser.new(cs_user_params)
    p "cs_user_params: #{cs_user_params}"

    respond_to do |format|
      if @cs_user.save
        format.html { redirect_to @cs_user, notice: 'Cs user was successfully created.' }
        format.json { render :show, status: :created, location: @cs_user }
      else
        format.html { render :new }
        format.json { render json: @cs_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cs_users/1
  # PATCH/PUT /cs_users/1.json
  def update
    respond_to do |format|
      if @cs_user.update(cs_user_params)
        format.html { redirect_to @cs_user, notice: 'Cs user was successfully updated.' }
        format.json { render :show, status: :ok, location: @cs_user }
      else
        format.html { render :edit }
        format.json { render json: @cs_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cs_users/1
  # DELETE /cs_users/1.json
  def destroy
    @cs_user.destroy
    respond_to do |format|
      format.html { redirect_to cs_users_url, notice: 'Cs user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cs_user
      @cs_user = CsUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cs_user_params
      params.require(:cs_user).permit(:nickname, :rol, enterprise_ids: [])
    end
end
