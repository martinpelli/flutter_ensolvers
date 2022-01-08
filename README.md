# flutter_ensolvers
A simple web application that allows you to create to-do items and folders to group them.

This is an app for the ensolvers team, 

Technologies:
-**frontend**: flutter
-**backend**: mongoose, MongoDB, Node.Js

-----What I have done:

-Phase 1
User Stories
- As a user, I want to be able to create, edit and delete to-do items
- As a user, I want to mark/unmark to-do items as completed

-Phase 2
User stories
- As a user, I want to be able to create and remove new folders. NOTE: removing new folders
will remove all the tasks belonging to it
- As a user, I want to be able to navigate to the item list inside a folder and manipulate the
items using the same UI implemented in Phase 1

Problems: [FIXED] (see [Updated])

I spent like 8 hs to only trying to fix an error with mongoose that didn't let me use two models, so the database is inconsistent, redundant. Instead of saving the tasks in folders, I would have been like to only save the tasks id, but at least is working. 
I didn't have enough time to upload the app and the DB. So it´s only working if you clone the repo and make the proper installs.

[Updated] (two days after the delivery)

- After trying everything, I was able to solve the problem by myself as I dind´t find nothing useful on Internet, now the database  complies with Normal Forms
- Deployed the app on the web and DB is now in remote at MongoDB Atlass

**To execute the app just run executeApp.bat**


