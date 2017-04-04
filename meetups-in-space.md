When we noticed that [Meetup.com][meetup] didn't allow users to create meetups that take place in space, we knew we had our new business plan.
Our goal is to disrupt the meetup space and bring synergy to meetup groups and their members throughout the entire universe.
Why limit our market to just Earth?

## Introduction

You'll be building a website similar to [Meetup.com][meetup] that allows users to sign up, join existing meetings, and even create their own meetup.

Meetups in Space is a little different from most of the challenges you have probably seen to date. It's focused on various aspects of ActiveRecord, and the end result will be a full-fledged, database-backed web application!

Most challenges are relatively short: they focus only on one or two concepts and are designed for a few hours' worth of work (an afternoon or evening).

This challenge is a **longer, more comprehensive project**, so you can expect to spend several such sessions working through it. Full web applications are usually not built in a day, so take your time with this challenge.

### Why the long challenge?

Rather than working with each ActiveRecord topic (Migrations, Associations, and Validations) independently, you will implement each component in the context of how it is actually used - in a real, live web application.

And by the end of this assignment, you'll have a deployable website that you can add to your GitHub portfolio.

This assignment will pull together many of the key concepts that we have covered to date (Sinatra, ActiveRecord, Acceptance Testing) in a way that starts to simulate the real-world experience of a professional web developer.

### Overall Goals

**Understand the importance of acceptance testing.** Requirements for this challenge are presented as user stories and acceptance criteria. Use these as a foundation to build your tests.

**See how everything fits together.** ActiveRecord Migrations, Associations, and Validations are all used in the context of building a broader web application. You will also see how ActiveRecord models work with your Sinatra server and views.

**Walk through the app planning process.** ER diagrams and database relationships form the foundation of your application. It's important to plan deliberately about what tables/models are needed, and what the relationships between them will be. ActiveRecord is simply a tool to implement these database relationships.

### Getting Started

When tackling any sizable body of work, it's important to break down that work into manageable chunks. To guide your progress, we've split out the work into three parts, with each part focusing on a different aspect of ActiveRecord: Migrations, Associations, and Validations.

As a rough guideline, you can expect each part to require the time and effort of one "normal" challenge.

Be sure to review the lessons on the relevant topics before diving into the work itself, and reference them as you go along.

## Part 1: ER Diagram and Migrations

### Key Topics

* Database Relationships (SQL)
* ActiveRecord Basics (CRUD)
* ActiveRecord Migrations

### Setting Up the Database

If you look in `config/database.yml` you can find the details of how to connect to your PostgreSQL database. In `db/migrate` you'll see that there is a migration that has already been written to create the `users` table.

Run the following commands to create and migrate your database:

```no-highlight
# Install all the dependencies for the app
$ bundle install

# Create the database
$ rake db:create

# Run all the migrations to get our schema up to date
$ rake db:migrate
```

### User Authentication

The authentication system has already been implemented using the OAuth standard with GitHub's authentication service. You'll need to register your development app with GitHub and provide your own application keys using the following instructions:

1. Go to your [application settings page][github-app-settings] on GitHub and register a new application (the name of the application doesn't matter).
2. Set your "Homepage URL" to `http://localhost:4567/`.
3. Set your "Authorization Callback URL" to `http://localhost:4567/auth/github/callback`.
4. Register your application.
5. Create a `.env` file in your project's root directory (same folder where `app.rb` is located).
6. Place all of your API keys in the `.env` file. The file's contents should look like this:

```no-highlight
SESSION_SECRET="replace_this_string_with_a_secret_of_your_choosing"
GITHUB_CLIENT_ID="replace_this_string_with_your_client_id_from_github"
GITHUB_CLIENT_SECRET="replace_this_string_with_your_client_secret_from_github"
```

At this point, run your test suite by running `rake`. The tests that have been provided for you should be passing. Also, you should start your server and open the application in your browser.

### Learning Objectives

* Effectively structure data to minimize duplication.
* Model connections between information using one-to-many and many-to-many relationships.

### Instructions

To start, read through the [core user stories][core-user-stories] to learn about what the finished app should do.

A good first step before approaching any problem is to go through the code you've been given to start with. Look through what has been already set up in the files provided here (mostly user authentication things), and try to get a general understanding of what you have to work with.

This part will be focused on designing and setting up the schema for the app. Once you're done looking through the existing code, your first step should be to plan out what tables you need, and what columns each one should have.

Next, use a tool like [draw.io](https://www.draw.io/) to create an ER diagram for your schema.

When your ER diagram is finished, create the migrations required to set up your database! Make sure to try rolling back each migration (`rake db:rollback`) to make sure that works, before you consider it finished.

When you finish these steps, start setting yourself up for future work on the above user stories. Don't worry yet about retrieving information from the database - that'll happen tomorrow - but you can get ready for that step by setting up the pages you'll need, and your paths in `app.rb`.

## Part 2: Associations

### Key Topics

* Acceptance Testing with ActiveRecord
* ActiveRecord Associations

### Learning Objectives

* Use ActiveRecord to associate tables
* Retrieve information from a database using ActiveRecord

### Instructions

* Create ActiveRecord models for each table in your database. They should be saved under `app/models`.
* Set up your models to use ActiveRecord associations. (This may involve making changes to your original plan for your schema - if that is the case, change your schema by adding new migrations, and be sure to update your ER diagram accordingly!)
* Once both of these steps are done, start fulfilling the [core user stories][core-user-stories]. You must start by writing an acceptance test for the desired behavior. Once you have written a test, write the code to get that test to pass.
* You should be using ActiveRecord to query your database and use the returned objects to display information on your erb pages.

### Tips

1. **Before you start writing any code**, take some time to think about how your database structure should be reflected in ActiveRecord associations.
2. Work on completing one user story at a time.
3. You will need to use a [has_many :through association][has-many-through].

## Part 3: Validations

### Key Topics

* ActiveRecord Validations

### Learning Objectives

* Use ActiveRecord validations at both the database and model level

### Instructions

* For each column in your database, decide what (if any) validations it should have for incoming data. Use [change_column](http://edgeguides.rubyonrails.org/active_record_migrations.html#changing-columns) to add database-level validations to each necessary column. `change_column` uses the following syntax:

  ```
  change_column table_name, column_name, column_type, constraints
  ```

  - For example, if I am adding a `null: false` constraint to my `name` column in a `songs` table, my migration might look like this:

  ```ruby
  class AddNullFalseToSongsName < ActiveRecord::Migration
    def up
      change_column :songs, :name, :text, null: false
    end
    def down
      change_column :songs, :name, :text
    end
  end
  ```

  - Note how `up` and `down` are used here for `change_column` rather than `change` - this is because `change_column` is something that cannot be rolled back automatically, meaning that it's up to us to explicitly state what should happen during a rollback.
* For each constraint you created in your database, create a corresponding validation in your model for that table.
* When you're done with both these steps, finish the [core user stories][core-user-stories] provided. If you have time, attempt the [optional user stories][optional-user-stories]!

## User Stories

### Core User Stories

```no-highlight
As a user
I want to view a list of all available meetups
So that I can get together with people with similar interests
```

Acceptance Criteria:

* On the meetups index page, I should see the name of each meetup.
* Meetups should be listed alphabetically.

The application should satisfy the following user stories:

```no-highlight
As a user
I want to view the details of a meetup
So that I can learn more about its purpose
```

Acceptance Criteria:

* On the index page, the name of each meetup should be a link to the meetup's show page.
* On the show page, I should see the name, description, location, and the creator of the meetup.

```no-highlight
As a user
I want to create a meetup
So that I can gather a group of people to do an activity
```

Acceptance Criteria:

* There should be a link from the meetups index page that takes you to the meetups new page. On this page there is a form to create a new meetup.
* I must be signed in, and I must supply a name, location, and description.
* If the form submission is successful, I should be brought to the meetup's show page, and I should see a message that lets me know that I have created a meetup successfully.
* If the form submission is unsuccessful, I should remain on the meetups new page, and I should see error messages explaining why the form submission was unsuccessful. The form should be pre-filled with the values that were provided when the form was submitted.

```no-highlight
As a user
I want to see who has already joined a meetup
So that I can see if any of my friends have joined
```

Acceptance Criteria:

* On a meetup's show page, I should see a list of the members that have joined the meetup.
* I should see each member's avatar and username.

```no-highlight
As a user
I want to join a meetup
So that I can partake in this meetup
```

Acceptance Criteria:

* On a meetup's show page, there should be a button to join the meetup if I am not signed in or if I am signed in, but I am not a member of the meetup.
* If I am signed in and I click the button, I should see a message that says that I have joined the meetup and I should be added to the meetup's members list.
* If I am not signed in and I click the button, I should see a message which says that I must sign in.

### Optional User Stories

**PLEASE DO NOT START THESE STORIES UNTIL YOU HAVE FINISHED PARTS 1-3 OF THE ASSIGNMENT AND THE CORE USER STORIES**:

```no-highlight
As a meetup creator
I want to change my meetup's details
So the meetup has up-to-date details
```

Acceptance Criteria:

* If I am signed in and I created the meetup, there should be a link from the meetup's show page that takes you to the meetup's edit page. On this page there is a form to edit the meetup, and it is pre-filled with the meetup's details.
* I must be signed and the meetup's creator, and I must supply a name, location, and description.
* If the form submission is successful, I should be brought to the meetup's show page, and I should see a message that lets me know that the meetup has been successfully updated.
* If the form submission is unsuccessful, I should remain on the meetup's edit page, and I should see error messages explaining why the form submission was unsuccessful. The form should be pre-filled with the values that were provided when the form was submitted.

```no-highlight
As a meetup creator
I want to cancel my meetup
So nobody comes to a meetup that is not taking place
```

Acceptance Criteria:

* If I am signed in and I created the meetup, there should be a delete button on the meetup's show page.
* If I click on the delete button, the meetup should be deleted and I should be redirected to the meetups index page. Also, all of the meetup's memberships should be deleted as well.

```no-highlight
As a meetup member
I want to leave a meetup
So that I'm no longer listed as a member of the meetup
```

Acceptance Criteria:

* On a meetup's show page, there should be a button to leave the meetup if I am signed in and I am a member of the meetup.
* If I click the button, I should see a message that says that I have left the meetup and I should be removed from the meetup's members list.


```no-highlight
As a user
I want to join a meetup without a page reload
So that I can have a seamless experience when joining a meetup
```

Acceptance Criteria:

* If I click the join meetup button, I will join the meetup without refreshing the page. I should see the join meetup up button become the leave meetup button, I should be added to the meetup's members list, and I should **NOT** see a message saying that I've successfully joined a meetup.
* If a user disables javascript, the join meetup functionality should still work with a page relaod (hint: create new route that your AJAX request utilizes rather than rewriting the original route).

```no-highlight
As a user
I want to leave a meetup without a page reload
So that I can have a seamless experience when leaving a meetup
```

Acceptance Criteria:

* If I click the leave meetup button, I will leave the meetup without refreshing the page. I should see the leave meetup up button become the join meetup button, I should be removed from the meetup's members list, and I should **NOT** see a message saying that I've successfully left the meetup.
* If a user disables javascript, the leave meetup functionality should still work. with a page reload.

```no-highlight
As a user
I want to see comments about a meetup
So I can see what other users are saying about the meetup
```

Acceptance Criteria:

* On a meetup's show page, there should be a list of comments. Each comment should include the body of the comment, the meetup member who left the comment, and the date of when the comment was created.
* Comments should be listed most recent first.

```no-highlight
As a meetup member
I want to leave comments on a meetup
So that I can communicate with other members of the group about the meetup
```

Acceptance Criteria:

* On the meetup's show page, if I am not signed, then there should be some text that tells me to login in order to comment.
* On the meetup's show page, if I am signed in, there should be a form to create a comment on the meetup.
* I must supply a body for the comment, and I must be a member of the group.
* If the form submission is successful, I should be brought to the meetup's show page, and I should see a message that lets me know that the comment has been successfully created and the comment added to the list of comments.
* If the form submission is unsuccessful, I should be brought to the meetup's show page, and I should see error messages explaining why the form submission was unsuccessful. The form should be pre-filled with the values that were provided when the form was submitted.

```no-highlight
As a comment creator
I want to erase a comment
So that I remove any comments that no longer apply
```

Acceptance Criteria:

* On the meetup's show page, if I am the creator of the comment, I should see a delete button next to it.
* When I click on the button, the comment should be deleted and I should see a message telling me that the comment was successfully deleted.

## Resources

* [Active Record Basics][active-record-basics]
* [Active Record Migrations][active-record-migrations]
* [Active Record Query Interface][active-record-query-interface]
* [Active Record Associations][active-record-associations]
* [Active Record Validations][active-record-validations]

[github-app-settings]: https://github.com/settings/applications/new
[meetup]: http://www.meetup.com/
[active-record-basics]: http://guides.rubyonrails.org/active_record_basics.html
[active-record-migrations]: http://guides.rubyonrails.org/active_record_migrations.html
[active-record-query-interface]: http://guides.rubyonrails.org/active_record_querying.html
[active-record-associations]: http://guides.rubyonrails.org/association_basics.html
[active-record-validations]: http://guides.rubyonrails.org/active_record_validations.html
[has-many-through]: http://guides.rubyonrails.org/association_basics.html#the-has-many-through-association
[core-user-stories]: https://learn.launchacademy.com/lessons/meetups-in-space#core-user-stories
[optional-user-stories]: https://learn.launchacademy.com/lessons/meetups-in-space#optional-user-stories
