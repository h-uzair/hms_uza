class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]



  def index
    if @doctor && @patient
      @appointments = Appointment.where(patient_id: @patient.id, doctor_id: @doctor.id)
    elsif @patient
      @appointments = Appointment.where(patient_id: @patient.id)
    elsif @doctor
      @appointments = Appointment.where(doctor_id: @doctor.id) 
    else
      @appointments = Appointment.all
    end
  end

  def show
  end

  def new
    @appointment = Appointment.new
  end

  def edit
  end
  
  def create
    @appointment = Appointment.new(appointment_params)
    
    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: 'Doctor appointment was successfully created.'}
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end  

  def update 
    








end
