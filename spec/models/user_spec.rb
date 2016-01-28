require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "1. NEW_USER VALIDATIONS:" do

    it 'a.) is VALID with a valids attributes' do
      expect(User.create(name: "raul", email: "raul@gmail.com", password: "12345678", password_confirmation: "12345678").valid?).to eq(true)
    end

    describe 'b.) is INVALID with a invalid:' do
    #* no test devise attributes
      
      it '- attribute of UNIQUENESS: name, email-devise*' do
        user = User.create(name: "raul", email: "raul@gmail.com", password: "12345678", password_confirmation: "12345678")
        user.save
        expect(User.create(name: "raul", email: "raoul@gmail.com", password: "12345678", password_confirmation: "12345678").valid?).to eq(false)
      end

      it '- attribute of PRESENCE: name, email-devise*, password-devise*, password_confirmation-devise*' do
        expect(User.create(name: nil, email: "raul@gmail.com", password: "12345678", password_confirmation: "12345678").valid?).to eq(false)
      end

      it '- attribute of LENGTH: name (< 26), password-devise*' do
        expect(User.create(name: "A2345678901234567890123456", email: "raul@gmail.com", password: "12345678", password_confirmation: "12345678").valid?).to eq(false)
      end

      it '- attribute of FORMAT: name (begin letter), email-devise*' do
        expect(User.create(name: "1aul", email: "raul@gmail.com", password: "12345678", password_confirmation: "12345678").valid?).to eq(false)
      end

    end

  end

  describe "2. USER has:" do

    before(:each) do
      @user = User.create(name: "raul", email: "raul@gmail.com", password: "12345678", password_confirmation: "12345678")
      @user.save
    end

    it 'a.) many PETS' do      
      @user.pets.create(name: "lola1", animal: "cat", birth: Date.today - 10.years, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg")
      @user.pets.create(name: "lola2", animal: "cat", birth: Date.today - 10.years, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg")
      expect(@user.pets.size).to eq(2)
    end

    it 'b.) not PETS' do
      expect(@user.pets.size).to eq(0)
    end

  end

end