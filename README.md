# README


# Home tech tet App

## About

- Project conversation history. A user should be able to:

  - leave a comment
  - change the status of the project
  - The project conversation history should list comments and changes in status.

## Getting Started

- This project requires Ruby 3.2.2 and Rails 7.0.4.3

- Setup app
  - clone the repo
  - `bundle`
  - Run `bin/rails db:setup`
  - run `bin/dev`
  - Visit `http://localhost:3000/` in your browser

## Running tests

- Seed the test database `$ bin/rails db:setup RAILS_ENV=test`
- Run `$ bundle exec rspec`

# Questions:

Q: Should the app have authentication?

A: yes using out of the box devise

Q: What are the attributes a project should have?

A: name, description, status.

Q: What are the attributes a comment should have?

A: name, user_id, project_id.

Q: Can only admin users change the status of the project?

A: All users can change the status of the project.

Q: What status can a project have?

A: The following status in_progress, completed,on_hold,cancelled, pending

Q Do project statues have to be changed in specific order?

A: No. User can can change status without any constraints.

Q Can user delete/update comments?

A: Yes

Q: Can any user comment on any project?

A: User can only comment in projects they belong to.
