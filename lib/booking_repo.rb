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