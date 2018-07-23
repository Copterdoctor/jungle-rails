require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it "Creates a new user with valid info" do
      user = User.new(:first_name => "TestName", :last_name => "LastName", :email => "example@example.com", :password => "password", :password_confirmation => "password")
      expect(user).to be_valid
      expect(user.errors.full_messages).to eq([])
    end

    it "Does not create a new user with no first name" do
      user = User.new(:first_name => "", :last_name => "LastName", :email => "example@example.com", :password => "password", :password_confirmation => "password")
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq(["First name can't be blank"])
    end

    it "Does not create a new user with no last name" do
      user = User.new(:first_name => "TestName", :last_name => "", :email => "example@example.com", :password => "password", :password_confirmation => "password")
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq(["Last name can't be blank"])
    end

    it "Does not create a new user with no email" do
      user = User.new(:first_name => "TestName", :last_name => "LastName", :email => nil, :password => "password", :password_confirmation => "password")
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq(["Email can't be blank"])
    end

    it "Does not create a new user with no password" do
      user = User.new(:first_name => "TestName", :last_name => "LastName", :email => "example@example.com", :password => "", :password_confirmation => "password")
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq(["Password can't be blank", "Password is too short (minimum is 8 characters)"])
    end

    it "Does not create a new user with no password confirmation" do
      user = User.new(:first_name => "TestName", :last_name => "LastName", :email => "example@example.com", :password => "password", :password_confirmation => "")
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq(["Password confirmation doesn't match Password"])
    end

    it "Does not create a new user with password less than 8 char" do
      user = User.new(:first_name => "TestName", :last_name => "LastName", :email => "example@example.com", :password => "passwor", :password_confirmation => "passwor")
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq(["Password is too short (minimum is 8 characters)"])
    end

    it "Does not create a new user with email already in db" do
      user = User.create(:first_name => "TestName", :last_name => "LastName", :email => "example@example.com", :password => "password", :password_confirmation => "password")
      user2 = User.create(:first_name => "TestName", :last_name => "LastName", :email => "example@example.com", :password => "password", :password_confirmation => "password")
      expect(user).to be_valid
      expect(user.errors.full_messages).to eq([])
      expect(user2).to_not be_valid
      expect(user2.errors.full_messages).to eq(["Email has already been taken"])
    end

    
  end

  describe '.authenticate_with_credentials' do
    it "Does authentic user" do
      user = User.create(:first_name => "TestName", :last_name => "LastName", :email => "example@example.com", :password => "password", :password_confirmation => "password")
      expect(User.authenticate_with_credentials(user, user[:email], "password")).to be true
    end
    
    it "Does authentic user with spaces infront of email" do
      user = User.create(:first_name => "TestName", :last_name => "LastName", :email => "  example@example.com", :password => "password", :password_confirmation => "password")
      expect(User.authenticate_with_credentials(user, user[:email], "password")).to be true
    end

    it "Does authentic user with spaces at end of email" do
      user = User.create(:first_name => "TestName", :last_name => "LastName", :email => "example@example.com  ", :password => "password", :password_confirmation => "password")
      expect(User.authenticate_with_credentials(user, user[:email], "password")).to be true
    end

    it "Does not authentic user without password" do
      user = User.create(:first_name => "TestName", :last_name => "LastName", :email => "example@example.com", :password => "password", :password_confirmation => "password")
      expect(User.authenticate_with_credentials(user, user[:email], nil)).to be false
    end

    it "Does not authentic user with wrong password" do
      user = User.create(:first_name => "TestName", :last_name => "LastName", :email => "example@example.com", :password => "password", :password_confirmation => "password")
      expect(User.authenticate_with_credentials(user, user[:email], "nil")).to be false
    end

    it "Does not authentic user without email" do
      user = User.create(:first_name => "TestName", :last_name => "LastName", :email => "example@example.com", :password => "password", :password_confirmation => "password")
      expect(User.authenticate_with_credentials(user, nil, "password")).to be false
    end

  end

end

