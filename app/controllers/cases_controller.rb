class CasesController < ApplicationController
  def index
    @cases = Case.all
  end

  def new
    @case = Case.new
    # same as:
    # @case.build_patient
    @case.patient = Patient.new
  end

  def show
    @case = Case.find(params[:id])
  end

  def create
    @case = Case.new(case_params)
    @case.patient = Patient.find(params[:case][:patient_id]) if params[:case][:patient_id]
    @case.user = current_user
    @case.save

    redirect_to case_path(@case)
  end

  def edit
    @case = Case.find(params[:id])
  end

  def update
    @case = Case.find(params[:id])

    if @case.update(case_params)
      redirect_to case_path(@case)
    else
      render :edit
    end
  end

  def destroy
    @case = Case.find(params[:id])
    @case.destroy

    redirect_to cases_path
  end

  private

  def case_params
    # Nested Attributes: create patient and case at the same time
    params.require(:case).permit(:description,
                                 patient_attributes: [:first_name, :last_name, :gender,
                                                      :date_of_birth, :address])
  end
end