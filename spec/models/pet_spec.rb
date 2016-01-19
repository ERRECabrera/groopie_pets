require 'rails_helper'

RSpec.describe Pet, type: :model do
  
  describe "1. NEW_PET VALIDATIONS:" do

    it 'a.) is VALID with a valids attributes' do
      user = User.create(name: "raul", email: "raul@gmail.com", password: "12345678", password_confirmation: "12345678")
      user.save
      expect(Pet.create(user_id: 1, name: "lola", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg").valid?).to eq(true)
    end

    describe 'b.) is INVALID with a invalid:' do
    #* no test paperclip attributes
      
      before(:each) do
        user = User.create(name: "raul", email: "raul@gmail.com", password: "12345678", password_confirmation: "12345678")
        user.save
      end

      it '- attribute of PRESENCE: name, animal' do
        expect(Pet.create(user_id: 1, name: nil, animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg").valid?).to eq(false)
        expect(Pet.create(user_id: 1, name: "lola", animal: nil, age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg").valid?).to eq(false)
      end

      it '- attribute of NUMERICALITY: age (integer and > -1)' do
        expect(Pet.create(user_id: 1, name: "lola", animal: "cat", age: "uno", image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg").valid?).to eq(false)
        expect(Pet.create(user_id: 1, name: "lola", animal: "cat", age: -1, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg").valid?).to eq(false)
      end

      it '- attribute of LENGTH: name (< 16)' do
        expect(Pet.create(user_id: 1, name: "1234567890123456", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg").valid?).to eq(false)
      end

      it '- attribute of INCLUSION: animal (category words)' do
        expect(Pet.create(user_id: 1, name: "lola", animal: "car", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg").valid?).to eq(false)
      end

    end

  end

  describe "2. PET:" do
  #work with attribute of PRESENCE: user_id

    it 'a.) NOT belong to USER - Invalid creation' do
      expect(Pet.create(name: "lola", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg").valid?).to eq(false)
    end
    
    it 'b.) YES belong to USER - Valid creation' do
      user = User.create(name: "raul", email: "raul@gmail.com", password: "12345678", password_confirmation: "12345678")
      user.save
      expect(user.pets.create(name: "lola", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg").valid?).to eq(true)
    end

  end

  describe "3. METHODS:" do

    before(:each) do
      @user = User.create(name: "raul", email: "raul@gmail.com", password: "12345678", password_confirmation: "12345678")
      @user.save
      @pet = @user.pets.create(name: "lola", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg")
      @user.pets.create(name: "juancho", animal: "reptile", age: 3, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg")
    end

    it '.name_user return user.name' do
      expect(@pet.name_user).to eq(@user.name)
    end

    it '.return_with_criterial return sort_list' do
      first_animal = Pet.return_with_criterial(@user.pets,{:id => :asc},1)[0] 
      last_animal = Pet.return_with_criterial(Pet.all,{:id => :desc},1)[0]
      expect(first_animal).to eq(Pet.first)
      expect(last_animal).to eq(Pet.last)
    end

    it '.image_thumb_url return image.url' do
      expect(@pet.image_thumb_url).to be_a_kind_of(String)
    end

    it '.image_original_url return image.url' do
      expect(@pet.image_original_url).to be_a_kind_of(String)
    end
    
  end

end
