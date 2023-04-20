require 'booking_repo'

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
      expect(result.length).to eq 14
      expect(result.last.booking_date).to eq "2023-05-14"
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

      expect(all_bookings.length).to eq 15
      expect(all_bookings.last.booking_date).to eq "2023-05-01"
      expect(all_bookings.last.space_id).to eq 1
    end
  end

  context "bookings_by_me" do
    it "returns the bookings by me based on status" do
      repo = BookingRepository.new
      confirmed_bookings = repo.bookings_by_me("confirmed", 1)

      expect(confirmed_bookings[1].booking_date).to include('2023-05-07')
      expect(confirmed_bookings[1].name).to include('Moria')
    end
  end
end