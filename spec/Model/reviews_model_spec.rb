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

  describe '#update_movie_average_rating' do
  let(:movie) { FactoryBot.create(:movie) }
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:review1) { FactoryBot.create(:review, movie: movie, user: user1, star: 4) }
  let(:review2) { FactoryBot.create(:review, movie: movie, user: user2, star: 3) }

  before do
    movie.reviews << [review1, review2]
    movie.update_average_rating
  end

  it 'updates the movie average rating' do
    expect(movie.rating).to eq(3)
  end
end
end


 



