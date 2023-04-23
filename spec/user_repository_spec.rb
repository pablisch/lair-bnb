require 'user_repo.rb'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do 
    reset_tables
  end

  it 'finds a users details based on email address' do
    repo = UserRepository.new
    user = repo.find_by_email('hobbit@example.com')

    expect(user.username).to eq('Bilbo')
    expect(user.email).to eq('hobbit@example.com')
    expect(user.id).to eq(1)
  end

  it 'finds user details based on id' do
    repo = UserRepository.new
    user = repo.find_by_id(1)
    
    expect(user.username).to eq('Bilbo')
    expect(user.email).to eq('hobbit@example.com')
  end
end