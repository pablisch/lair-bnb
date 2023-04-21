require_relative './booking'
require_relative './space_repo'
require_relative './space'

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
    if booking.status.nil?
      fail "Missing status"
    elsif booking.space_id.nil?
      fail "Missing space_id"
    end
    sql = 'INSERT INTO bookings (booking_date, status, space_id, guest_id) VALUES ($1, $2, $3, $4);'
    params = [booking.booking_date, booking.status, booking.space_id, booking.guest_id]
    DatabaseConnection.exec_params(sql, params)
  end

  def bookings_by_me(status, id)
    sql = 'SELECT bookings.booking_date, bookings.status, bookings.id,
    bookings.space_id, bookings.guest_id, spaces.name, spaces.description, spaces.price
    FROM bookings
    INNER JOIN spaces ON spaces.id=bookings.space_id
    WHERE status = $1 AND guest_id = $2;'
    params = [status, id]
    result = DatabaseConnection.exec_params(sql, params)
    bookings = []
    result.each{ |row| bookings << bookings_builder(row) }
    return bookings
  end

  def filter_owned(status, user_id)
    user_repo = UserRepository.new
    sql = 'SELECT bookings.booking_date, bookings.status, bookings.id,
    bookings.space_id, bookings.guest_id, spaces.name, spaces.description, spaces.price
    FROM bookings
    INNER JOIN spaces ON spaces.id=bookings.space_id
    WHERE status = $1 AND user_id = $2;'

    params = [status, user_id]
    results = DatabaseConnection.exec_params(sql, params)

    bookings = []
    results.each do |record|
      bookings << [record['space_id'], record['name'], record['booking_date'], user_repo.find_by_id(record['guest_id']), record['id']]
    end

    return bookings
  end

  def update_booking(id, status)
    sql = 'UPDATE bookings SET status = $1 WHERE id = $2;'
    params = [status, id]

    DatabaseConnection.exec_params(sql, params)
  end

  def delete_booking(id)
    sql = 'DELETE FROM bookings WHERE id = $1;'
    params = [id]
    
    DatabaseConnection.exec_params(sql, params)
  end

  private

  def bookings_builder(row)
    booking = Booking.new
    booking.booking_date = row['booking_date']
    booking.status = row['status']
    booking.space_id = row['space_id'].to_i
    booking.guest_id = row['guest_id'].to_i
    booking.name = row['name']
    booking.price = row['price'].to_f
    booking.description = row['description']
    return booking
  end
end
