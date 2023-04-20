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


  context "#all_except_owner" do
    it "returns all space object except those owned by the logged in user" do
      repo = SpaceRepository.new
      results = repo.all_except_owner(1)
      expect(results.length).to eq 3
      expect(results[0].id).to eq 2
      expect(results[0].name).to eq "Winterfell"
      expect(results[0].description).to include "rustic charm"
      expect(results[0].price).to eq 120.0
      expect(results[0].available_from).to eq "2023-05-03"
      expect(results[0].available_to).to eq "2023-05-17"
      expect(results[0].user_id).to eq 2
    end
  end

  context "#create" do
    it "creates a new space" do
      repo = SpaceRepository.new
      space = Space.new

      space.name = "Test Space"
      space.description = "Space Description"
      space.price = 10
      space.available_from = "2023-05-01"
      space.available_to = "2023-05-01"
      space.user_id = 1

      repo.create(space)
      
      results = repo.all
      expect(results.length).to eq 6
      expect(results.last.name).to eq('Test Space')
      expect(results.last.description).to eq('Space Description')

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

  context "get available dates" do
    it "returns available dates of a space" do
      repo = SpaceRepository.new
      result = repo.get_available_dates(1)
      expect(result).to include('2023-05-10')
    end
  end

  context 'get a space based on date selection' do
    it 'returns spaces with date between [2023-05-1] - [2023-5-10]' do
      repo = SpaceRepository.new
      result = repo.get_available_dates_filter('2023-05-01', '2023-5-10')
      expect(result.length).to eq 1
      expect(result[0].id).to eq 1
      expect(result[0].name).to eq "Bag End"
      expect(result[0].description).to include "Charming and cosy"
      expect(result[0].price).to eq 70.0
      expect(result[0].available_from).to eq "2023-05-01"
      expect(result[0].available_to).to eq "2023-05-15"
      expect(result[0].user_id).to eq 1
    end
  end
end