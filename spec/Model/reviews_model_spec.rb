require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'associations' do
    it { should belong_to(:movie) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    subject { FactoryBot.build(:review) }

    it { should validate_uniqueness_of(:user_id).scoped_to(:movie_id) }
  end

  describe 'callbacks' do
    let(:movie) { FactoryBot.create(:movie) }
    let!(:review1) { FactoryBot.create(:review, movie: movie) }
    let!(:review2) { FactoryBot.create(:review, movie: movie) }

    it 'updates the movie average rating after save' do
      expect(movie).to receive(:update_average_rating)
      review1.save
    end

    it 'updates the movie average rating after destroy' do
      expect(movie).to receive(:update_average_rating)
      review2.destroy
    end
  end
end
