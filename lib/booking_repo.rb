require_relative './booking'

class BookingRepository
  def all
    sql = 'SELECT * FROM bookings'
    result = DatabaseConnection.exec_params(sql, [])
    bookings = []
    result.each do |row|
      booking = Booking.new
      booking.booking_date = row['booking_date']
      booking.status = row['status']
      booking.space_id = row['space_id'].to_i
      booking.guest_id = row['guest_id'].to_i
      bookings << booking
    end
    return bookings
  end

  def create(booking)
    sql = 'INSERT INTO bookings (booking_date, status, space_id, guest_id) VALUES ($1, $2, $3, $4);'
    params = [booking.booking_date, booking.status, booking.space_id, booking.guest_id]
    DatabaseConnection.exec_params(sql, params)
  end

  def filter_owned(status, space_ids)
    spaces = []

    space_ids.each do |id|
      sql = 'SELECT * FROM bookings WHERE status = $1 AND space_id = $2;'
      params = [status, id]

      result_set = DatabaseConnection.exec_params(sql, params)

      bookings = []
      result_set.each do |row|
        booking = Booking.new
        booking.booking_date = row['booking_date']
        booking.status = row['status']
        booking.space_id = row['space_id'].to_i
        booking.guest_id = row['guest_id'].to_i
        bookings << booking
      end

      spaces << bookings
    end
  end
end
