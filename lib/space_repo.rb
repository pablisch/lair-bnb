require 'space'

class SpaceRepository
  def all 
    sql = 'SELECT * FROM spaces;'
    results = DatabaseConnection.exec_params(sql,[])

    spaces = []
    results.each { |record| spaces << space_builder(record) }
    return spaces
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