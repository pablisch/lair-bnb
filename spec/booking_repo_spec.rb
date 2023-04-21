require 'booking_repo'
require_relative '../lib/space_repo'

RSpec.describe BookingRepository do
  
  before(:each) do
    reset_tables
  end

  context "show all bookings" do
    it "lists all bookings" do
      repo = BookingRepository.new
      result = repo.all
      expect(result.length).to eq 13
      expect(result.last).to (having_attributes(
        booking_date: "2023-05-14",
        status: "denied",
        space_id: 5,
        guest_id: 1
        )
      )
    end
  end

  context "creating a new booking" do
    it "creates a booking based on user params" do
      repo = BookingRepository.new
      booking = Booking.new
      booking.booking_date = "2023-05-01"
      booking.status = "pending"
      booking.space_id = 1
      booking.guest_id = 3

      new_booking = repo.create(booking)
      all_bookings = repo.all

      expect(all_bookings.length).to eq 14
      expect(all_bookings.last.booking_date).to eq "2023-05-01"
      expect(all_bookings.last.space_id).to eq 1
    end

    it "creates two bookings based on user params" do
      repo = BookingRepository.new
      booking = Booking.new
      booking.booking_date = 20230704
      booking.status = "pending"
      booking.space_id = 2
      booking.guest_id = 5
      repo.create(booking)

      booking = Booking.new
      booking.booking_date = 20230804
      booking.status = "confirmed"
      booking.space_id = 1
      booking.guest_id = 6
      repo.create(booking)

      all_bookings = repo.all

      expect(all_bookings.length).to eq 15
      expect(all_bookings.last.booking_date).to eq "2023-08-04"
      expect(all_bookings.last.space_id).to eq 1
      expect(all_bookings).to include(having_attributes(
        booking_date: "2023-07-04",
        space_id: 2,
        guest_id: 5
        )
      )
    end

    it "error when the status field is missing" do
      repo = BookingRepository.new
      booking = Booking.new
      booking.booking_date = "2023-05-01"
      booking.status = nil
      booking.space_id = 1
      booking.guest_id = 3

      expect{ repo.create(booking) }.to raise_error("Missing status")
    end

    it "error when the space_id field is missing" do
      repo = BookingRepository.new
      booking = Booking.new
      booking.booking_date = "2023-05-01"
      booking.status = "denied"
      booking.space_id = nil
      booking.guest_id = 3

      expect{ repo.create(booking) }.to raise_error("Missing space_id")
    end

  end

  context "bookings_by_me" do
    it "returns the bookings by me based on status" do
      repo = BookingRepository.new
      confirmed_bookings = repo.bookings_by_me("confirmed", 1)

      expect(confirmed_bookings[1].booking_date).to include('2023-05-22')
      expect(confirmed_bookings[1].name).to include('Moria')
    end
  end

  context "filter bookings on owned spaces" do
    it "returns an array of bookings which have pending requests" do
      repo = BookingRepository.new

      result = repo.filter_owned('pending', 2)

      expect(result.length).to eq 2
      expect(result[0][1]).to eq 'Winterfell'
      expect(result[0][2]).to eq '2023-05-07'
      expect(result[0][3].username).to eq 'Amber'
    end

    it "returns an array of bookings which have confirmed requests" do
      repo = BookingRepository.new

      result = repo.filter_owned('confirmed', 1)

      expect(result.length).to eq 3
      expect(result[0][1]).to eq 'The Burrow'
      expect(result[0][2]).to eq '2023-05-07'
      expect(result[0][3].username).to eq 'Amber'
    end
  end

  context "#update_booking" do
    it "changes a booking status from pending to confirmed" do
      repo = BookingRepository.new
      repo.update_booking(1, 'confirmed')

      bookings = repo.all

      expect(bookings.last.status).to eq 'confirmed'
      expect(bookings.last.booking_date).to eq '2023-05-10'
      expect(bookings.last.space_id).to eq 1
      expect(bookings.last.guest_id).to eq 2
    end

    it "changes a booking status from pending to denied" do
      repo = BookingRepository.new
      repo.update_booking(1, 'denied')

      bookings = repo.all

      expect(bookings.last.status).to eq 'denied'
      expect(bookings.last.booking_date).to eq '2023-05-10'
      expect(bookings.last.space_id).to eq 1
      expect(bookings.last.guest_id).to eq 2
    end
  end
end


