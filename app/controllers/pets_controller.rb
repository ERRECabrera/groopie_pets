class PetsController < ApplicationController
  
  before_action :authenticate_user!

  LIMIT_LIST = 30
  DATAS_INCLUDE = {
    :only => [:id, :name, :animal, :birth],
    :methods => [:user_name, :images_urls, :age]
  }

  #get 'pets/all'
  def index
    pets_list = Pet.desc_sorted_by_id.limit(LIMIT_LIST)
    if pets_list.size > 0
      render status: :ok, :json => pets_list.to_json(DATAS_INCLUDE)
    else
      render status: :not_found, :json => { error: "pets list not found"}
    end
  end

  #get 'pets/user'
  def return_user_pets
    pets_list = current_user.pets.desc_sorted_by_id
    if pets_list.size > 0
      render status: :ok, :json => pets_list.to_json(DATAS_INCLUDE)
    else
      render status: :not_found, :json => { error: "pets list not found"}
    end
  end

  #get 'pets/:id/info'
  def show
    pet = Pet.find_by_id(params[:id])
    if pet
      render status: :ok, json: pet.to_json(DATAS_INCLUDE)
    else
      render status: :not_found, :json => { error: "pet not_found"}
    end
  end

  #post 'pets/form'
  def return_form
    if params[:pet]
      @pet = Pet.find_by_id(pet_params[:id])
    elsif
      @pet = Pet.new
    end
    render 'form', layout: 'clean'
  end

  #post 'pets/create'
  def create
    pet = current_user.pets.create(pet_params)
    if pet.save
      flash[:notice] = 'Pet created'
      #render status: :created, json: pet.to_json #this is single page version
      redirect_to(root_path)
    else
      flash[:alert] = 'Error: Unprocessable entity'
      #render status: :unprocessable_entity, :json => { error: "unprocessable"} #this is single page version
      redirect_to(root_path)
    end
  end

  #post 'pets/update'
  def update
    if pet_params[:id]
      pet = current_user.pets.find_by_id(pet_params[:id])
      if pet.update_attributes(pet_params)
        flash[:notice] = 'Pet updated'
        #render status: :accepted, :json => pet.to_json #this is single page version
        redirect_to(root_path)
      else
        flash[:alert] = 'Error: Unprocessable entity'
        #render status: :unprocessable_entity, :json => { error: "unprocessable"} #this is single page version
        redirect_to(root_path)
      end
    else
      flash[:alert] = 'Error: Pet not found'
      #render status: :not_found, :json => { error: "not_found"} #this is single page version
      redirect_to(root_path)
    end
  end

  #post 'pets/destroy'
  def destroy
    if pet_params[:id]
      pet = current_user.pets.find_by_id(pet_params[:id])
      if pet.destroy
        flash[:notice] = 'Pet deleted'
        #render status: :ok, :json => nil.to_json #this is single page version
        redirect_to(root_path)
      else
        flash[:alert] = 'Error: Unprocessable entity'
        #render status: :unprocessable_entity, :json => { error: "unprocessable"} #this is single page version
        redirect_to(root_path)
      end
    else
      flash[:alert] = 'Error: Pet not found'
      #render status: :not_found, :json => { error: "not_found"} #this is single page version
      redirect_to(root_path)
    end
  end

private

  def pet_params
    params.require(:pet).permit(:id, :name, :animal, :birth, :image) 
  end

end