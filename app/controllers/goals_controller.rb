class GoalsController < ApplicationController
  before_action :set_goal, only: %i[ show edit update destroy ]

  # GET /goals or /goals.json
  def index
    @goals = Goal.all.includes(:okrs) # Fetch all goals with associated OKRs

    # Calculate completion status for each goal
    @goals.each do |goal|
      goal.completion_status = calculate_goal_completion_status(goal)
    end
  end

  # GET /goals/1 or /goals/1.json
  def show
  end

  # GET /goals/new
  def new
    @goal = Goal.new
  end

  # GET /goals/1/edit
  def edit
  end

  # POST /goals or /goals.json
  def create
    @goal = Goal.new(goal_params)

    respond_to do |format|
      if @goal.save
        format.html { redirect_to goal_url(@goal), notice: "Goal was successfully created." }
        format.json { render :show, status: :created, location: @goal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /goals/:id/update_okrs
  def update_okrs
    @goal = Goal.find(params[:id])

    # Update OKRs based on form data
    okr_params = params.require(:goal).permit(okr_completion_statuses: [])
    okr_params[:okr_completion_statuses].each_with_index do |completion_status, index|
      @goal.okrs[index].update(completion_status: completion_status)
    end

    # Optionally, handle response (e.g., render JSON, redirect)
    respond_to do |format|
      format.html { redirect_to goals_path, notice: 'OKRs updated successfully.' }
      format.json { render json: { message: 'OKRs updated successfully.' } }
    end
  end

  # PATCH/PUT /goals/1 or /goals/1.json
  def update
    respond_to do |format|
      if @goal.update(goal_params)
        format.html { redirect_to goal_url(@goal), notice: "Goal was successfully updated." }
        format.json { render :show, status: :ok, location: @goal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goals/1 or /goals/1.json
  def destroy
    @goal.destroy

    respond_to do |format|
      format.html { redirect_to goals_url, notice: "Goal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def calculate_goal_completion_status(goal)
    return 0 if goal.okrs.empty? # If there are no OKRs, completion status is 0

    completed_okrs_count = goal.okrs.where(completion_status: true).count
    total_okrs_count = goal.okrs.count

    # Calculate the percentage completion
    completion_percentage = (completed_okrs_count.to_f / total_okrs_count) * 100
    completion_percentage.round(2) # Round to two decimal places
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_goal
    @goal = Goal.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def goal_params
    params.require(:goal).permit(:name, :description, :completion_status)
  end
end
