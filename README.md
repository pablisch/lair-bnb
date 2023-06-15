# Lair BnB

### Setup and run tests
```bash
# Clone [repo](https://github.com/pablisch/lair-bnb) and install gems
bundle install
# To run tests
rspec
# To run the server (better to do this in a separate terminal)
rackup
# Open browser and go to localhost:9292
```

The first engineering project on the Makers Software Development course. The aim was to build a clone of AirBnB using Ruby, Sinatra, Postgres and RSpec.

### Database information

The databases for this project are `makersbnb` and `makersbnb_test`.
Table and seeds information in spec folder.

To create local DBs

 ```sh
 createdb makersbnb
 createdb makersbnb_test
 ```

 Then, to create and populate the tables run the following:

 ```sh
psql -h 127.0.0.1 makersbnb < spec/tables.sql
psql -h 127.0.0.1 makersbnb < spec/seeds.sql
psql -h 127.0.0.1 makersbnb_test < spec/tables.sql
psql -h 127.0.0.1 makersbnb_test < spec/seeds.sql
 ```

### Technologies used in this project

* Ruby
* RSpec
* ERB
* Sinatra
* Rack
* Git
* CSS
* Postgres
* Javascript

and assisted by:
* GitHub
* Postman
* TablePlus

