require 'rails_helper'

RSpec.describe PetsController, type: :controller do

  describe '#get_all_list' do
    
    before(:each) do
      @user = User.create(name: "raul", email: "raul@gmail.com", password: "12345678", password_confirmation: "12345678")
      sign_in @user
    end

    it 'SOME pets in DDBB return pets_list in JSON' do
      @user.pets.create(name: "lola", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg")
      pets = @user.pets
      get :get_all_list
      expect(response.body).to eq(pets.to_json(:only => [:id, :name, :animal, :age], :methods => [:name_user, :image_thumb_url, :image_original_url]))
    end

    it 'NO pets in DDBB return status NOT_FOUND' do
      get :get_all_list
      expect(response).to have_http_status(:not_found)
    end

  end

  describe '#get_user_list' do
    
    before(:each) do
      @user1 = User.create(name: "raul", email: "raul@gmail.com", password: "12345678", password_confirmation: "12345678")
      @user2 = User.create(name: "otro", email: "otro@gmail.com", password: "12345678", password_confirmation: "12345678")
    end

    it 'when current_user HAS pets in DDBB return pets_list in JSON' do
      @user1.pets.create(name: "lola", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg")
      pets = @user1.pets
      sign_in @user1
      get :get_user_list
      expect(response.body).to eq(pets.to_json(:only => [:id, :name, :animal, :age], :methods => [:name_user, :image_thumb_url, :image_original_url]))
    end

    it 'when current_user NOT_HAS pets in DDBB return status NOT_FOUND' do
      @user2.pets.create(name: "lola", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg")
      sign_in @user1
      get :get_user_list
      expect(response).to have_http_status(:not_found)
    end

  end

  describe '#get_info' do
    
    before(:each) do
      @user = User.create(name: "raul", email: "raul@gmail.com", password: "12345678", password_confirmation: "12345678")
      sign_in @user
    end

    it 'return INFO_PET in JSON when exist the pet.id in DDBB' do
      pet = @user.pets.create(name: "lola", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg")
      #pet not is an array
      get :get_info, {:id => 1}
      expect(response.body).to eq(pet.to_json(:only => [:id, :name, :animal, :age], :methods => [:name_user, :image_thumb_url, :image_original_url]))
    end

    it 'return status NOT_FOUND when no exist the pet.id in DDBB' do
      get :get_info, {:id => 1}
      expect(response).to have_http_status(:not_found)
    end

  end

  describe '#get_modal_form' do
  render_views

    before(:each) do
      @user = User.create(name: "raul", email: "raul@gmail.com", password: "12345678", password_confirmation: "12345678")
      @user.pets.create(name: "lola", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg")
      sign_in @user
    end

    it 'render FORM template' do
      post :get_modal_form
      expect(response).to render_template(:form)
    end

    it 'fill form with PET_NEW' do
      post :get_modal_form
      expect(response.body).to match /Save/
    end

    it 'fill form with PET_DDBB' do
      post :get_modal_form, {pet: { id: 1}}
      expect(response.body).to match /Update/ && /Delete/
    end
    
  end

  describe '#controller_form' do

    describe 'pseudoredirect_to:' do

      before(:each) do
        @user = User.create(name: "raul", email: "raul@gmail.com", password: "12345678", password_confirmation: "12345678")
        sign_in @user
      end
      
      it '#CREATE a NEW_PET is DONE' do
        post :controller_form, { :pet => {id: nil, name: "lola", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg"}, create: "create" }
        expect(Pet.all.size).to eq(1)
      end

      it '#CREATED NEW_PET is current_user PROPERTY' do
        post :controller_form, { :pet => {id: nil, name: "lola", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg"}, create: "create" }
        expect(Pet.last.user_id).to eq(@user.id)
      end

      it '#CREATE a NEW_PET have a PROBLEM with ATTRIBUTES' do
        post :controller_form, { :pet => {id: nil, name: nil, animal: nil, age: nil, image: nil}, create: "create" }
        expect(Pet.all.size).to eq(0)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it '#CREATE a NEW_PET have a PROBLEM with REDIRECT' do
        post :controller_form, { :pet => {id: nil, name: "lola", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg"} }
        expect(Pet.all.size).to eq(0)
        expect(response).to have_http_status(:not_found)
      end

      it '#UPDATE a INFO_PET is DONE' do
        @user.pets.create(name: "lola", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg")
        post :controller_form, { :pet => {id: 1, name: "lola", animal: "dog", age: 1, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg"}, update: "update" }
        expect(response).to have_http_status(:accepted)
        expect(Pet.find_by_name('lola').animal).to eq('dog')
      end

      it '#UPDATE a INFO_PET have a PROBLEM with UPDATE_ATTRIBUTES' do
        @user.pets.create(name: "lola", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg")
        post :controller_form, { :pet => {id: 1, name: nil, animal: nil, age: nil, image: nil}, update: "update" }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it '#UPDATE a INFO_PET have a PROBLEM with PET.ID' do
        @user.pets.create(name: "lola", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg")
        post :controller_form, { :pet => {id: nil, name: "lola", animal: "dog", age: 1, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg"}, update: "update" }
        expect(response).to have_http_status(:not_found)
      end

      it '#UPDATE a INFO_PET have a PROBLEM with REDIRECT' do
        @user.pets.create(name: "lola", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg")
        post :controller_form, { :pet => {id: 1, name: "lola", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg"} }
        expect(response).to have_http_status(:not_found)
      end


      it '#DESTROY a PET is DONE' do
        @user.pets.create(name: "lola", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg")
        post :controller_form, { :pet => {id: 1, name: "lola", animal: "dog", age: 1, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg"}, destroy: "destroy" }
        expect(response).to have_http_status(:ok)
        expect(Pet.all.size).to eq(0)
      end

      it '#DESTROY a PET have a PROBLEM with PET.ID' do
        @user.pets.create(name: "lola", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg")
        post :controller_form, { :pet => {id: nil, name: "lola", animal: "dog", age: 1, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg"}, destroy: "destroy" }
        expect(response).to have_http_status(:not_found)
      end

      it '#DESTROY a PET have a PROBLEM with REDIRECT' do
        @user.pets.create(name: "lola", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg")
        post :controller_form, { :pet => {id: 1, name: "lola", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg"} }
        expect(response).to have_http_status(:not_found)
      end
    
    end

  end

end