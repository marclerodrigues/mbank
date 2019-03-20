# MBank

## What is it?
An open-source project to help banks managing their accounts and clients.

## Dependencies

The application was created with the following environment:

- `Ruby 2.6.0`
- `Rails 5.2.2`
- `PostgreSQL 10.4`

## How to setup?

1. First check if your Ruby, Rails and PostgresQL are matching the versions above and properly configured;

2. Then you can run:

  ```
  bin/setup
  ```

  All the required steps will be performed and then you can run your server:

  ```
  bundle exec rails server -p 3000 -b 0.0.0.0
  ```

  Then you can go to `localhost:3000` and you will see the project is up and running.

3. Remember, sometimes you will have to tweek the `config/database.yml` file to match your database configuration. If you get any errors related to the database configuration you can tweek your file and re-run the `bin/setup` command.

## How to use the system?

We have three endpoints implemented in the system, documented below:

**Create users**
----
  Accepts attributes for creating a new user and returns json with the user access token in case of successfull creation.

* **/users**
  /users

* **Method:**
  `POST`

* **URL Params**
  None

* **Data Params**
  ** Required **
  `user[first_name]=[string]`
  `user[last_name]=[string]`
  `user[email]=[string]`

* **Successful Response**
  * **Code:** 200 <br />
    **Content:** `{"success":true,"access_token":"access-token"}`

* **Error Response**
  * **Code:** 422 UNPROCESSABLE_ENTITY <br/>
    **Content:** `{"success":false,"errors":'["First name must be present"] }`

* **Sample Call:**
 ```
 curl -d '{"user":{ "first_name":"John", "last_name":"Doe", "email":"john@doe.com"}}' -H "Content-Type: application/json" -X POST http://localhost:3000/users
 ```

**Transfer funds**
----
  Transfer funds from source account to destination account.

* **/transfers**
  /transfers

* **Method:**
  `POST`

* **URL Params**
  None

* **Data Params**
  ** Required **
  `transfer[source_account_id]=[integer]`
  `transfer[destination_account_id]=[integer]`
  `transfer[amount]=[integer]`

* **Successful Response**
  * **Code:** 200 <br />
    **Content:** `{ success: true }`

* **Error Response**
  * **Code:** 422 UNPROCESSABLE_ENTITY <br/>
    **Content:** `{ success: false, errors: ["Account not found"] }`

* **Sample Call:**
 ```
 curl -d '{"transfer":{ "source_account_id":1, "destination_account_id":2, "amount":1000, "access_token":"token"}}' -H "Content-Type: application/json" -X POST http://localhost:3000/transfers
 ```

**Show current balance**
----
  Show account's current balance

* **/balance**
  /balance/:account_id

* **Method:**
  `GET`

* **URL Params**
  **Require**
  `account_id=[integer]`

* **Data Params**
  None

* **Successful Response**
  * **Code:** 200 <br />
    **Content:** `{ success: true, balance: 1000 }`

* **Error Response**
  * **Code:** 404 NOT_FOUND <br/>
    **Content:** `{ success: false, errors: ["Account not found"] }`

* **Sample Call:**
 ```
 curl -X GET http://localhost:3000/balance/1"
 ```


## How to run the test suite?

1. You can just run `bundle exec rspec`.

## How to contribute with it?

If you want to contribute for the 'Headhunter 42', clone the project GitLab repository with the following:

```git clone git@github.com:marclerodrigues/mbank.git```

Create a new branch and make your contributions, after push to the created branch and
request the merge. You code will be reviewed and merged with the master branch if
no modification are needed.

## Project's Guide Lines

### Describing a Pull request

1. Describe what was done in your branch.
2. An issue link
3. If you have UI changes in your PR. Take a screenshot or make a GIT of the changes and add it to the PR.

### How to name a branch

1. Prefix the name of the brach with the type of the story you are working.

    1. If you are configuring the Gemfile for example. branch -> config/Gemfile

    2. If you are creating a new feature called User. branch -> feature/User

    3. If you are creating a new feature under a namescope, lets's say Admin::User. brach -> feature/admin/user


# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
