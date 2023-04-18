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
    user = repo.find_by_email('amber@example.com')

    expect(user.username).to eq('Amber')
    expect(user.email).to eq('amber@example.com')
  end
end