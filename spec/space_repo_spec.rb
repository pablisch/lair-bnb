require 'space_repo'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

RSpec.describe SpaceRepository do
  before(:each) do
    reset_tables
  end
  
  context "#all" do
    it "returns all space object" do
      repo = SpaceRepository.new
      results = repo.all
      expect(results.length).to eq 5
      expect(results[0].id).to eq 1
      expect(results[0].name).to eq "Bag End"
      expect(results[0].description).to include "Charming and cosy"
      expect(results[0].price).to eq 70.0
      expect(results[0].available_from).to eq "2023-05-01"
      expect(results[0].available_to).to eq "2023-05-15"
      expect(results[0].user_id).to eq 1
    end
  end

  context "#new" do
    it "creates a new space" do
      repo = SpaceRepository.new
      space = Space.new

      space.name = "Test Space"
      space.description = "Space Description"
      space.price = 10
      space.available_from = "2023-05-01"
      space.available_to = "2023-05-01"
      space.user_id = 1

      repo.new(space)
      
      results = repo.all
      expect(results.length).to eq 6
    end
  end

  context "find_by_id method" do 
    it "returns a single space object based on id" do
      repo = SpaceRepository.new
      result = repo.find_by_id(1)
      expect(result).to (having_attributes(
          name: 'Bag End',
          description: 'Charming and cosy with a quirky front door',
          price: 70,
          available_from: '2023-05-01',
          available_to: '2023-05-15',
          user_id: 1
        )
      )
    end
  end

end