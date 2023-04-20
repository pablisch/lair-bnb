require_relative './space'
require 'date'

class SpaceRepository
  def all 
    sql = 'SELECT * FROM spaces;'
    results = DatabaseConnection.exec_params(sql,[])

    spaces = []
    results.each { |record| spaces << space_builder(record) }
    return spaces
  end

  def create(space)
    sql = 'INSERT INTO spaces (name, description, price, available_from, available_to, user_id) VALUES ($1, $2, $3, $4, $5, $6);'
    params = [space.name, space.description, space.price, space.available_from, space.available_to, space.user_id]
    DatabaseConnection.exec_params(sql, params)
  end

  def find_by_id(id)
    sql = 'SELECT * FROM spaces WHERE id = $1'
    result_set = DatabaseConnection.exec_params(sql, [id])
    return space = space_builder(result_set[0])
  end

  def all_except_owner(user_id)
    sql = 'SELECT * FROM spaces WHERE user_id != $1;'
    params = [user_id]
    results = DatabaseConnection.exec_params(sql, params)

    spaces = []
    results.each { |record| spaces << space_builder(record) }
    return spaces
  end

  def get_booked_dates(space_id, status)
    sql = 'SELECT booking_date FROM bookings WHERE space_id = $1 AND status = $2;'
    params = [space_id, status]
    result = DatabaseConnection.exec_params(sql, params)
    dates = []
    result.each do |record|
      dates << Date.parse(record['booking_date']).strftime("%Y-%m-%d")
    end
    return dates
  end

  def get_available_dates(space_id)
    sql = 'SELECT available_from, available_to FROM spaces WHERE id = $1;'
    params = [space_id]
    result = DatabaseConnection.exec_params(sql, params)

    dates = []

    result.each do |row|
      dates << Date.parse(row['available_from'])
      dates << Date.parse(row['available_to'])
    end

    dates_array = []

    (dates[0]..dates[1]).step(1) do |date|
      dates_array << date.strftime("%Y-%m-%d")# - "2005-01-01"
    end

    return dates_array - get_booked_dates(space_id, 'confirmed')
  end

  private 

  def space_builder(record)
    space = Space.new
    space.id = record['id'].to_i
    space.name = record['name']
    space.description = record['description']
    space.price = record['price'].to_f
    space.available_from = record['available_from']
    space.available_to = record['available_to']
    space.user_id = record['user_id'].to_i
    return space
  end 
  
end