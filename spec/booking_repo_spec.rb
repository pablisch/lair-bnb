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
      expect(result.length).to eq 8
      expect(result.last).to (having_attributes(
        booking_date: "2023-05-13",
        status: "denied",
        space_id: 5,
        guest_id: 8
        )
      )
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

      expect(all_bookings.length).to eq 9
      expect(all_bookings.last.booking_date).to eq "2023-05-01"
      expect(all_bookings.last.space_id).to eq 1
    end
  end
end