require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe '#update_average_rating' do

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:category) }
    it { should have_many(:reviews).dependent(:destroy) }
    it { should have_many(:users).through(:reviews).dependent(:destroy) }
    it { should have_one_attached(:image) }
  end

  describe 'attachments' do 
    it { should have_one_attached(:image) }
  end

    let(:movie) { FactoryBot.create(:movie) }

    it 'updates the average rating based on reviews' do
      review1 = FactoryBot.create(:review, movie: movie, star: 4)
      review2 = FactoryBot.create(:review, movie: movie, star: 3)
      

      expect(movie).to receive(:save)

      movie.update_average_rating

      expect(movie.rating).to be_within(0.5).of(3.5)
    end
  end
end
