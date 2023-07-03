require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:reviews).dependent(:destroy) }
    # it { should have_many(:movies).through(:reviews).dependent(:destroy) }
    it { should have_many(:movies).dependent(:destroy) }
  end    

  describe 'Devise configuration' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password).on(:create) }
    it { should validate_length_of(:password).is_at_least(6).on(:create) }
    it { should validate_confirmation_of(:password) }
    # it { should have_secure_password }
  end

  describe 'enum role' do
    it { should define_enum_for(:role).with_values(user: 0, admin: 1) }
  end
end

 