require_relative './user'

class UserRepository
  def find_by_email(email) 
    sql = 'SELECT id, username, email, password FROM users WHERE email = $1;'
    result_set = DatabaseConnection.exec_params(sql, [email])

    return nil if !result_set.ntuples.positive?
    find_user = User.new
    find_user.id = result_set[0]['id'].to_i
    find_user.email = result_set[0]['email']
    find_user.password = result_set[0]['password']
    find_user.username = result_set[0]['username']

    return find_user
  end

  def find_by_id(id) 
    sql = 'SELECT id, username, email, password FROM users WHERE id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [id])

    return nil if !result_set.ntuples.positive?
    find_user = User.new
    find_user.id = result_set[0]['id'].to_i
    find_user.email = result_set[0]['email']
    find_user.password = result_set[0]['password']
    find_user.username = result_set[0]['username']

    return find_user
  end
end