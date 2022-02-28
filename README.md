# BUGZILLA

Bugzilla is an application for keeping record of bugs. The manager will create the Projects and assign team to it. The team can be a developer or a software quality assurance. Since the users can be of three types i.e 
1. Manager
2. Developer
3. Software Quality Assuarance

## Roles
### Manager
  Manager can create/edit/delete the projects he/she created.
  Manager can view Bugs that a project has.
  
### Developer
  A developer can only view projects to which he belongs. The developer can also view details of projects and list of all the bugs the project has. The developer can then select from the list of bugs to assign himself and update. 
**Restrictions**
A developer can not create/Edit a Project.
A developer can not create/Delete a bug. 

### Quality Assurance
The QA can view list of all projects, but can not create/edit/delete a project. 
The QA can create new bugs. 

# Getting Started
## Prerequisites
This is an example of What ruby and rails versions you need to use the software.
 - ruby 2.7.2
 - rails 5.2.6.2

## Gem dependencies
  - gem 'bootstrap', '~> 4.4.1'
  - gem 'cloudinary'
  - gem 'devise'
  - gem 'jquery-rails'
  - gem 'pundit'

## Configuration
Below is an example of how you can instruct your audience on installing and setting up your app. This template doesn't rely on any external dependencies or services.
1. Clone the repo.

    `git clone https://github.com/Talal-Z/Bugzilla.git`

2. after clone, you need to install all the dependencies.

    `bundle install`
  
3. Go to terminal and run the following command
  
    `rails s`

## Deployment instructions
If you’re using an existing app that was created without specifying --database=postgresql, you need to add the pg gem to your Rails project. Edit your Gemfile and change this line
`gem 'sqlite3'`
with the gem
`gem 'pg'`
and then run `bundle install` on rails

then configure your [database.yml](https://devcenter.heroku.com/articles/getting-started-with-rails5) file.

Push your code to the git repository.
Last but not the least, sign up at heroku if you dont have account and connect your github account with heroku account. 

use the github repository and branch you wish to deploye. 
then using the CLI run the command

`heroku run rake db:migrate`

If you have seeding file. Then also run 

`heroku run rake db:seed`
