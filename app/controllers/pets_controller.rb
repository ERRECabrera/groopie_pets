class PetsController < ApplicationController
  before_action :authenticate_user!

  def get_all_list
    pets_list = Pet.return_with_criterial(Pet.all,{id: :desc},100)
    if pets_list.size > 0
      render status: :ok, :json => pets_list.to_json(:only => [:id, :name, :animal, :age], :methods => [:name_user, :image_thumb_url, :image_original_url] )
    else
      render status: :not_found, :json => { error: "not_found"}
    end
  end

  def get_user_list
    user = User.find_by_id(current_user.id)
    pets_list = Pet.return_with_criterial(user.pets,{id: :desc})
    if pets_list.size > 0
      render status: :ok, :json => pets_list.to_json(:only => [:id, :name, :animal, :age], :methods => [:name_user, :image_thumb_url, :image_original_url] )
    else
      render status: :not_found, :json => { error: "not_found"}
    end
  end

  def get_info
    pet = Pet.find_by_id(params[:id])
    if pet
      render status: :ok, json: pet.to_json(:only => [:id, :name, :animal, :age], :methods => [:name_user, :image_thumb_url, :image_original_url] )
    else
      render status: :not_found, :json => { error: "not_found"}
    end
  end

  def get_modal_form
    if params[:pet]
      @pet = Pet.find_by_id(pet_params[:id])
    elsif
      @pet = Pet.new
    end
    render 'form'
  end
  
  def controller_form
    session[:pet_data] = pet_params
    if params[:create]
      create
    elsif params[:update]
      update
    elsif params[:destroy]
      destroy
    else
      render status: :not_found, :json => { error: "not_found"}
    end
  end
  
  def create
    user = User.find_by_id(current_user.id)
    pet = user.pets.create(session[:pet_data])
    if pet.save
      render status: :created, json: user.pets.last.to_json
    else
      render status: :unprocessable_entity, :json => { error: "unprocessable"}
    end
  end

  def update
    user = User.find_by_id(current_user.id)
    if session[:pet_data][:id]
      pet = user.pets.find_by_id(session[:pet_data][:id])
      if pet.update_attributes(session[:pet_data])
        render status: :accepted, :json => pet.to_json
      else
        render status: :unprocessable_entity, :json => { error: "unprocessable"}
      end
    else
      render status: :not_found, :json => { error: "not_found"}
    end
  end

  def destroy
    user = User.find_by_id(current_user.id)
    if session[:pet_data][:id]
      pet = user.pets.find_by_id(session[:pet_data][:id])
      if pet.destroy
        render status: :ok, :json => nil.to_json
      else
        render status: :unprocessable_entity, :json => { error: "unprocessable"}
      end
    else
      render status: :not_found, :json => { error: "not_found"}
    end
  end

private

  def pet_params
    params.require(:pet).permit(:id, :name, :animal, :age, :image) 
  end

end