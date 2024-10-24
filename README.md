# README
REEFAPI

ReefAPI is a Ruby on Rails API application that manages stores, items, and ingredients with features like pagination, searching, and background jobs. This guide walks you through setting up the application for development.

Before setting up the project, ensure you have the following installed:

    Ruby (version 3.2.1)
    PostgreSQL (version 12 or higher)
    Bundler (for managing Ruby gems)

Getting started:
1. Clone the Repository

`git clone https://github.com/your_username/ReefAPI.git`
`cd ReefAPI`

2. Install Ruby Gems
`bundle install`

3. Set Up PostgreSQL Database
 a. Install PostgreSQL
  If you don't have PostgreSQL installed, you can install it as follows:

  macOS (using Homebrew):
  `brew install postgresql`
  `brew services start postgresql`
  Ubuntu/Debian:
  `sudo apt update`  
  `sudo apt install postgresql postgresql-contrib`
  `sudo systemctl start postgresql`
 b. Create PostgreSQL User
   `psql -U postgres`
   `CREATE USER reef WITH PASSWORD 'your_password';`
   `ALTER USER reef WITH CREATEDB;`
 c. Make sure the database.yml File configured correctly.
 d. Create and Migrate Databases:
    `rails db:create`
    `rails db:migrate`
4. Running Tests:
    `RAILS_ENV=test rails db:create`
    `RAILS_ENV=test rails db:migrate`
    `bundle exec rspec`
    This will create the test database, run migrations, and execute the tests using RSpec.

5. Testing the API Locally

You can now use Postman to test the API endpoints.

    Download Postman: If you haven’t installed Postman yet, download it from Postman Official Site.

    Make Requests:
        Open Postman and create a new request.
        Set the request type (e.g., GET, POST, PUT, DELETE).
        Enter the API endpoint URL (e.g., http://localhost:3000/stores).
        Add any necessary query parameters, headers, or body data for requests.

    Example Requests:

        GET All Stores:
            URL: http://localhost:3000/stores
            Method: GET

        Create a New Store:

            URL: http://localhost:3000/stores
            Method: POST
            Body (JSON):

    {
      "store": {
        "name": "My New Store",
        "address": "123 Main St"
      }
    }

    Update a Store:
    URL: http://localhost:3000/stores/1
    Method: PUT
    Body (JSON):

    {
      "store": {
        "name": "Updated Store",
        "address": "456 Main St"
      }
    }

    Delete a Store:
    URL: http://localhost:3000/stores/1
    Method: DELETE
