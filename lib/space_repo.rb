require_relative './space'

class SpaceRepository
  def all 
    sql = 'SELECT * FROM spaces;'
    results = DatabaseConnection.exec_params(sql,[])

    spaces = []
    results.each { |record| spaces << space_builder(record) }
    return spaces
  end

  def new(space)
    sql = 'INSERT INTO spaces (name, description, price, available_from, available_to, user_id) VALUES ($1, $2, $3, $4, $5, $6);'
    params = [space.name, space.description, space.price, space.available_from, space.available_to, space.user_id]
    DatabaseConnection.exec_params(sql, params)
  end

  def find_by_id(id)
    sql = 'SELECT * FROM spaces WHERE id = $1'
    result_set = DatabaseConnection.exec_params(sql, [id])
    return space = space_builder(result_set[0])
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