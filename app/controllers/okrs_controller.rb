class OkrsController < ApplicationController
  before_action :set_okr, only: %i[ show edit update destroy ]

  # GET /okrs or /okrs.json
  def index
    @okrs = Okr.all
  end

  # GET /okrs/1 or /okrs/1.json
  def show
  end

  # GET /okrs/new
  def new
    @okr = Okr.new
  end

  # GET /okrs/1/edit
  def edit
  end

  # POST /okrs or /okrs.json
  def create
    @okr = Okr.new(okr_params)

    respond_to do |format|
      if @okr.save
        format.html { redirect_to okr_url(@okr), notice: "Okr was successfully created." }
        format.json { render :show, status: :created, location: @okr }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @okr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /okrs/1 or /okrs/1.json
  def update
    respond_to do |format|
      if @okr.update(okr_params)
        format.html { redirect_to okr_url(@okr), notice: "Okr was successfully updated." }
        format.json { render :show, status: :ok, location: @okr }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @okr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /okrs/1 or /okrs/1.json
  def destroy
    @okr.destroy

    respond_to do |format|
      format.html { redirect_to okrs_url, notice: "Okr was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_okr
      @okr = Okr.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def okr_params
      params.require(:okr).permit(:description, :completion_status, :goal_id)
    end
end
