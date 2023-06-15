# Lair BnB

The first engineering project on the Makers Software Development course. The aim was to build a clone of AirBnB using Ruby, Sinatra, Postgres and RSpec.

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

### Images of app in use

Homepage:
![Homepage](/images/lair-bnb-homepage.png)

[lair](images/lair-bnb-lair-page.png)

<!-- add image using public/images/lair-bnb-homepage.png -->
[!lair-bnb-homepage.png]

