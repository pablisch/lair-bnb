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

  def filter_owned(status, user_id)

    sql = 'SELECT bookings.booking_date, bookings.status, bookings.id,
    bookings.space_id, bookings.guest_id, spaces.name, spaces.description, spaces.price
    FROM bookings
    INNER JOIN spaces ON spaces.id=bookings.space_id
    WHERE status = $1 AND user_id = $2;'

    params = [status, user_id]
    results = DatabaseConnection.exec_params(sql, params)

    bookings = []
    results.each do |record|
      bookings << [record['name'], record['booking_date'], record['guest_id']]
    end
    return bookings
  end
  #   spaces = []

  #   space_ids.each do |id|
  #     sql = 'SELECT name FROM spaces WHERE id = $1;'
  #     params = [id]
  #     result_name = DatabaseConnection.exec_params(sql, params)
      
  #     sql = 'SELECT * FROM bookings WHERE status = $1 AND space_id = $2;'
  #     params = [status, id]
  #     result_set = DatabaseConnection.exec_params(sql, params)

  #     bookings = []
  #     result_set.each do |row|
  #       booking = Booking.new
  #       booking.booking_date = row['booking_date']
  #       booking.status = row['status']
  #       booking.space_id = row['space_id'].to_i
  #       booking.guest_id = row['guest_id'].to_i
  #       bookings << booking
  #     end

  #     spaces << bookings
  #   end
  # end
end
