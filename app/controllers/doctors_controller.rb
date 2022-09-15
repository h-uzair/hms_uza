class DoctorsController < ApplicationController
before_action :set_doctor, only: [:show, :edit, :update, :destroy]


  def index
    first_name = request.query_parameters['firstName']
    last_name = request.query_parameters['lastName']
    if first_name && last_name
      @doctors = Doctor.where(first_name: first_name.to_s.capitalize, last_name: last_name.to_s.capitalize)
    else
      @doctors = Doctor.all
    end

  end

  def show
  end

  def new
    @doctor = Doctor.new
  end

  def edit
  end

  def login
    @doctor = Doctor.new
  end

  def logout
    session.delete(:doctor_id)
     redirect_to :controller => 'home', :action => 'index'
  end

  def signin
    @doctor = Doctor.new(login_params)
    _doctor = Doctor.where(username: login_params[:username], password: login_params[:password]).first()
    if login_params[:d_id]
      _doctor.update_column(:gcmid, login_params[:d_id])
    end
    respond_to do |format|
      if _doctor
        @doctor = _doctor
        session[:doctor_id] = @doctor.id
        format.html { redirect_to :controller => 'home', :action => 'index'  }
        format.json { render :show, status: :created, location: @doctor }
      else
        @doctor.errors.add(:username, :blank, message: "Invalid credentials")
        format.html { render :login }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @doctor = Doctor.new(doctor_params)

    respond_to do |format|
      if @doctor.save
        format.html { redirect_to @doctor, notice: 'Doctor was successfully created.' }
        format.json { render :show, status: :created, location: @doctor }
      else
        format.html { render :new }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @doctor.update(doctor_params)
        format.html { redirect_to @doctor, notice: 'Doctor was successfully updated.' }
        format.json { render :show, status: :ok, location: @doctor }
      else
        format.html { render :edit }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @doctor.destroy
    respond_to do |format|
      format.html { redirect_to doctors_url, notice: 'Doctor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_doctor
      @doctor = Doctor.find(params[:id])
    end


    def doctor_params
      params.require(:doctor).permit(:first_name, :last_name, :city, :username, :password, :address, :doctor_practice)
    end

    def login_params
      params.require(:doctor).permit(:username, :password,)
    end

end
