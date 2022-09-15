class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  def index
    @patients = Patient.all
  end

  def show
  end

  def logout
    session.delete(:patient_id)
     redirect_to :controller => 'home', :action => 'index'
  end

  def login
    @patient = Patient.new
  end

  def signin
    @patient = Patient.new(login_params)
    _patient = Patient.where(username: login_params[:username], password: login_params[:password]).first()
    if login_params[:p_id]
      _patient.update_column(:p_id, login_params[:p_id])
    end
    respond_to do |format|
      if _patient
        @patient = _patient
        session[:patient_id] = _patient.id
        format.html { redirect_to :controller => 'home', :action => 'index'  }
        format.json { render :show, status: :created, location: _patient }
      else
        @patient.errors.add(:username, :blank, message: "Invalid credentials")
        format.html { render :login }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @patient = Patient.new
  end

  def edit
  end

  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: 'Patient was successfully created.' }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    def set_patient
      @patient = Patient.find(params[:id])
    end

    def patient_params
      params.require(:patient).permit(:first_name, :last_name, :city, :username, :password, :address, :p_id)
    end

    def login_params
      params.require(:patient).permit(:username, :password, :p_id)
    end

end
