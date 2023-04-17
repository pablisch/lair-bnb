# MakersBnB

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

### Setup and run tests
```
# Clone [repo](https://github.com/pablisch/makersbnb) and install gems
bundle install
# To run tests
rspec
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

and assisted by:
* GitHub
* Postman
* TablePlus

# MakersBnB Project Seed instructions

This repo contains the seed codebase for the MakersBnB project in Ruby (using Sinatra and RSpec).

Someone in your team should fork this seed repo to their Github account. Everyone in the team should then clone this fork to their local machine to work on it.

## Setup

```bash
# Install gems
bundle install

# Run the tests
rspec

# Run the server (better to do this in a separate terminal).
rackup
```
