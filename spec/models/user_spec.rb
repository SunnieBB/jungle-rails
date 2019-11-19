require 'rails_helper'

RSpec.describe User, type: :model do
  subject {describe_class.new(first_name: 'Sun', last_name: 'Sun', email: 'sun@gmail.com', password: '128', password_confirmation: '128')}

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

    it 'fails to save when first name is not set' do
      subject.first_name = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when last name is not set' do
      subject.last_name = nil
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

    it 'fails to save when password and password_confirmation does not match' do
      subject.password_confirmation = '000'
      subject.valid?
      expect(subject.errors).not_to be_empty
    end
    
    it 'fails to save when email is not unique (not case sensitive)' do
      User.create(:first_name => 'Sun', :last_name => 'Sun', :email => 'sun@gamil.com', :password => "128", :password_confirmation => "128", :password_digest => "111")
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
end
