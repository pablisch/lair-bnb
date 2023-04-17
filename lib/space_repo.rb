require 'space'

class SpaceRepository
  def all 
    sql = 'SELECT * FROM spaces;'
    results = DatabaseConnection.exec_params(sql,[])

    spaces = []
    results.each { |record| spaces << space_builder(record) }
  end

  private 

  def space_builder(record)
    space = Space.new
    space.id = record['id']
    space.name = record['name']
    space.description = record['description']
    space.price = record['price']
    space.available_from = record['available_from']
    space.available_to = record['available_to']
    space.user_id = record['user_id']
    return space
  end 
  
end