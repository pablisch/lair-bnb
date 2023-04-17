require 'space_repo'

RSpec.describe SpaceRepository do
  
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
end