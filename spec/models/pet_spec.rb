require 'rails_helper'

RSpec.describe Pet, type: :model do
  
  describe "1. NEW_PET VALIDATIONS:" do

    it 'a.) is VALID with a valids attributes' do
      user = User.create(name: "raul", email: "raul@gmail.com", password: "12345678", password_confirmation: "12345678")
      user.save
      expect(Pet.create(user_id: 1, name: "lola", animal: "cat", birth: Date.today - 10.years, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg").valid?).to eq(true)
    end

    describe 'b.) is INVALID with a invalid:' do
    #* no test paperclip attributes
      
      before(:each) do
        user = User.create(name: "raul", email: "raul@gmail.com", password: "12345678", password_confirmation: "12345678")
        user.save
      end

      it '- attribute of PRESENCE: name, animal' do
        expect(Pet.create(user_id: 1, name: nil, animal: "cat", birth: Date.today - 10.years, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg").valid?).to eq(false)
        expect(Pet.create(user_id: 1, name: "lola", animal: nil, birth: Date.today - 10.years, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg").valid?).to eq(false)
      end

      it '- attribute of LENGTH: name (< 16)' do
        expect(Pet.create(user_id: 1, name: "1234567890123456", animal: "cat", birth: Date.today - 10.years, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg").valid?).to eq(false)
      end

      it '- attribute of INCLUSION: animal (category words)' do
        expect(Pet.create(user_id: 1, name: "lola", animal: "car", birth: Date.today - 10.years, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg").valid?).to eq(false)
      end

      it '- attribute of DATE: birth (> Date.today)' do
        expect(Pet.create(user_id: 1, name: "lola", animal: "cat", birth: Date.today + 10.years, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg").valid?).to eq(false)
      end

    end

  end

  describe "2. PET:" do
  #work with attribute of PRESENCE: user_id

    it 'a.) NOT belong to USER - Invalid creation' do
      expect(Pet.create(name: "lola", animal: "cat", birth: Date.today - 10.years, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg").valid?).to eq(false)
    end
    
    it 'b.) YES belong to USER - Valid creation' do
      user = User.create(name: "raul", email: "raul@gmail.com", password: "12345678", password_confirmation: "12345678")
      user.save
      expect(user.pets.create(name: "lola", animal: "cat", birth: Date.today - 10.years, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg").valid?).to eq(true)
    end

  end

  describe "3. METHODS:" do

    before(:each) do
      @user = User.create(name: "raul", email: "raul@gmail.com", password: "12345678", password_confirmation: "12345678")
      @user.save
      @pet = @user.pets.create(name: "lola", animal: "cat", birth: Date.today - 10.years, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg")
      @user.pets.create(name: "negrito", animal: "dog",  birth: Date.today - 7.day, image: "https://www.petfinder.com/wp-content/uploads/2012/11/93394608-pets-welcome-policy-632x475.jpg")
      @user.pets.create(name: "juancho", animal: "reptile",  birth: Date.today - 1.month, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg")
    end

    context '.return_age_string' do

      it 'if pet age is < 1 year' do
        expect(Pet.last.age).to include('months')
      end

      it 'if pet age is: < 1 year && < month' do
        expect(Pet.all[1].age).to include('days')
      end
      
      it 'if pet age is >= 1 year' do
        expect(Pet.first.age).to include('years')  
      end
    end

  end

  describe '4. INSTANCE AND CLASS ATTRIBUTES' do

    before(:each) do
      @user = User.create(name: "raul", email: "raul@gmail.com", password: "12345678", password_confirmation: "12345678")
      @user.save
      @user.pets.create(name: "lola", animal: "cat", birth: Date.today - 10.years, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg")
      @pet = @user.pets.first
    end
  
    context 'after find' do
          
      it '.user_name return user.name' do
        expect(@pet.user_name).to eq(@user.name)
      end

      it '.images_urls return hash with all urls img_styles' do
        expect(@pet.images_urls[:original]).to be_a_kind_of(String)
        expect(@pet.images_urls[:zoom]).to be_a_kind_of(String)
        expect(@pet.images_urls[:thumb]).to be_a_kind_of(String)
      end

      it '.animal_species return pet species' do
        expect(@pet.animal_species[0]).to be_a_kind_of(String)
        expect(@pet.animal_species).to be_a_kind_of(Array)
      end

      it '.age return how old is the pet' do
        expect(@pet.age).to be_a_kind_of(String)
      end

    end
    
  end

  describe '5. SCOPES to:' do

    before(:each) do
      @user = User.create(name: "raul", email: "raul@gmail.com", password: "12345678", password_confirmation: "12345678")
      @user.save
      @pet = @user.pets.create(name: "lola", animal: "cat", birth: Date.today - 10.years, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg")
      @user.pets.create(name: "juancho", animal: "reptile",  birth: Date.today - 1.month, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg")
    end

    it '.desc_sorted_by_id return a desc_sort_list_by_id of pets' do
      last_animal = Pet.desc_sorted_by_id[0]
      expect(last_animal).to eq(Pet.last)
    end
    
  end

end
