require 'rails_helper'

RSpec.describe Movie, type: :model do
 

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

  describe "validations" do

    let(:user) { User.create(email: 'test@example.com', password: 'password',role: "admin") }
    let(:category) { Category.create(name: "Action") }

    it "requires a name" do
      movie = Movie.new(name: nil, released_on: Date.today)
      expect(movie).not_to be_valid
      expect(movie.errors[:name]).to include("can't be blank")
    end

    it "requires a released_on date" do
      movie = Movie.new(name: "Example Movie", released_on: nil)
      expect(movie).not_to be_valid
      expect(movie.errors[:released_on]).to include("can't be blank")
    end

    it "is valid with a name and released_on date" do
      movie = Movie.new(name: "Example Movie", released_on: Date.today,user_id: user.id,category_id: category.id)
      expect(movie).to be_valid
    end
  end


  describe '#update_average_rating' do
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



