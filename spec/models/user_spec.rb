require 'rails_helper'

RSpec.describe User, type: :model do
  subject {described_class.new(:name => 'Sun', :email => 'sun@gmail.com', :password => "128", :password_confirmation => "128")}
  describe 'Validation' do
  
    it 'saves successfully when all four fields are set' do
      subject.valid?
      expect(subject.errors).to be_empty
    end

    it 'fails to save when email is not set' do
      subject.email = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when name is not set' do
      subject.name = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when password is not set' do
      subject.password = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when password_confirmation is not set' do
      subject.password_confirmation = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when password and password_confirmation is not identical' do
      subject.password_confirmation = '000'
      subject.valid?
      expect(subject.errors).not_to be_empty
    end
    
    it 'fails to save when email is not unique (not case sensitive)' do
      User.create(:name => 'Sun', :email => 'sun@gmail.com', :password => "128", :password_confirmation => "128", :password_digest => "111")
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when password and password_confirmation is less than length 3' do
      subject.password = '11'
      subject.password_confirmation = '11'
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

  end
  
  describe '.authenticate_with_credentials' do
    it 'allows user to login if succesfully authenticated' do
      subject.save
      user = User.authenticate_with_credentials('sun@gmail.com', '128')
      expect(subject).to be == user
    end

    it 'fails to login if unsuccessfully authenticated' do
      subject.save
      user = User.authenticate_with_credentials('sun@gmail.com', 'sss')
      expect(user).to be == nil
    end

    it 'authenticates users even if white space is typed before and/or after email' do
      subject.save
      user = User.authenticate_with_credentials(' sun@gmail.com ', '128')
      expect(subject).to be == user
    end

    it 'allows emails to be non-case sensitive and authenticates the user to login' do
      subject.save
      user = User.authenticate_with_credentials('sUn@gMaIl.com', '128')
      expect(subject).to be == user
    end
  end

end
