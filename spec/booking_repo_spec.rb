require 'booking_repo'
require_relative '../lib/space_repo'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

RSpec.describe BookingRepository do
  before(:each) do
    reset_tables
  end

  context "show all bookings" do
    it "lists all bookings" do
      repo = BookingRepository.new
      result = repo.all
      expect(result.length).to eq 11
      expect(result.last.booking_date).to eq "2023-05-13"
    end
  end

  context "creating a new booking" do
    it "creates a booking based on user params" do
      repo = BookingRepository.new
      booking = Booking.new
      booking.booking_date = "2023-05-01"
      booking.status = false
      booking.space_id = 1
      booking.guest_id = 3

      new_booking = repo.create(booking)
      all_bookings = repo.all

      expect(all_bookings.length).to eq 12
      expect(all_bookings.last.booking_date).to eq "2023-05-01"
      expect(all_bookings.last.space_id).to eq 1
    end
  end

  context "filter requests on owned spaces" do
    it "returns an array of spaces which have pending requests" do
      repo = BookingRepository.new
      # space_repo = SpaceRepository.new
      # owned_spaces = space_repo.all_owned_spaces(1)
      # ids = space_repo.owned_space_ids(owned_spaces)

      result = repo.filter_owned('pending', 2)

      expect(result.length).to eq 3
      # expect(result[0][0].booking_date).to eq '2023-05-10'
      # expect(result[0][0].status).to eq 'pending'
      # expect(result[0][0].space_id).to eq 1
      # expect(result[0][0].guest_id).to eq 2
      # expect(result[1]).to eq []
    end
  end
end

