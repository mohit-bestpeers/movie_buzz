
FactoryBot.define do
  factory :movie do
    name { "Test Movie" }
    released_on { Date.today }
    rating { 3.0 }
    description {"fdsgrdsgr"}
    director {"kuldddp"}
    user
    category
  end  
end
