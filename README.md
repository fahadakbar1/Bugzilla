# README

Intro:

Bugzilla is an application where

 A Manager can create a project, add developer Developers and Qas to that project.
 A QA can add bugs and feature to the projects
 A Developer can check those projects which are assigned by the Manager.
 He can assign the bugs/features to himself and then resolve those bugs / complete those features

Requirements:
ruby '2.6.8'

Steps to get the application up and running.

1. Clone this repository and set it up on your local device. How?

  (i)  Fork this repo and copy the repo url
 (ii) Open your terminal and change your directory to where you want to place the repo.
(iii) Write " git clone (Paste url you just copied) "

After entering your github password it will take some time and you will have a folder with the same name as repo

2. Change your directory to that folder

3. Check your ruby version. It should be (ruby 2.6.8)

4. Check gemfile it should have rolify, pundit and cloudinary.

5. If you are unable to find them add them to gemfile and run bundle install.

6. Then run " rake db:seed "

7. Run " rails s "

You have your application up and running on http://localhost:3000


