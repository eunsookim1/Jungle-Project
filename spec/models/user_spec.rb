require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validations' do
    it 'requires password and password_confirmation fileds' do
      @user = User.new(
        name: 'Sarah',
        email: 'sarah@gmail.com',
        password: 'password', 
        password_confirmation: 'mismatch'
        )
        
        expect(@user.save).to be(false)
        expect(@user.errors.full_messages.to_sentence).to eq("Password confirmation doesn't match Password")
        @user.valid?
    end

    it 'requires Emails must be unique (not case sensitive; for example, TEST@TEST.com should not be allowed if test@test.COM is in the database)' do
      @user1 = User.new(
        name: 'user1',
        email: 'test@test.COM',
        password: 'password', 
        password_confirmation: 'password'
        )
      @user1.save
      @user1.valid?

      @user2 = User.new(
        name: 'user2',
        email: 'TEST@TEST.com',
        password: 'password', 
        password_confirmation: 'password'
        )
      expect(@user2.save).to be(false)
      # @user2.valid?
        
        # expect(@user2.save).to be(false)
        # expect(@user.errors.full_messages.to_sentence).to eq("Password confirmation doesn't match Password")
        # @user.valid?
    end

    it 'validates presence of name' do
      @user = User.new(
        name: nil,
        email: 'Test@gmail.com',
        password: 'password'
      )
      @user.valid?
      # puts @user.errors.full_messages.to_sentence
      expect(@user.errors.full_messages.to_sentence).to eq("Name can't be blank")
    end

    it 'validates presence of email' do
      @user = User.new(
        name: 'Test',
        email: nil, 
        password: 'password'
      )

      @user.valid?
      expect(@user.errors.full_messages.to_sentence).to eq("Email can't be blank")
    end

    it 'validates the password must have a minimum length when a user account is being created' do
      user = User.new(
        name: 'Test',
        password: 'short',
        email: 'tests@gmail.com'
        )
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include('is too short (minimum is 8 characters)')
      
    end

    
  end


  describe '.authenticate_with_credentials' do
    it "validates user email and password" do
      @user = User.new({
            name:  Faker::Name.name,
            email: Faker::Internet.email,
            password: '123*Testing',
            password_confirmation: '123*Testing'
          })
      @user.save! # ! is saying try to save the user if error throw the error.
      user = User.authenticate_with_credentials(@user.email.upcase, @user.password);
      expect(user.id).to be_present 
    end
  end
end
