# Door client
this little rails app is providing a client for the web numa de montmollin's door webservice

# Usage

1. clone it
2. run `bundle`
3. run `rake db:migrate`
4. `rails s`
5. visit `localhost:3000`

# Technology

For detailled gem usage see the Gemfile. Otherwise this app use sqlite as database and massive javascript.

# Functionality

1. can register, delete a door
2. can list all registred doors
3. can show infos of a specific doors
4. store every changes for every registred door
5. live selected door infos update
6. can mdofify state of a door
7. one signle page, without reload. Everything in js
8. Responsive design
