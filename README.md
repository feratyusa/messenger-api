# CHALLENGE MESSANGER API

My solution to Challenge of making Messanger API using Ruby on Rails within 3 days of development process.

## Use Case

1. User Authenticated can send message to other users.
2. User Authenticated can not send empty message to other user.
3. User Reply to Existing conversation from other users.
4. User can see list of conversations from other users (list of conversation, last message, other user basic info, and unread message count)

## Technology

* Rails v6.1.7
* Ruby v2.7.2
* Database postgreSQL
* Bundle v2.1.4

## Check

Run `bundle exec rspec` and make sure all result is green (without error) :)

### Result

![Test Result][result_file.jpg]

## Explanation

### Models

There are 4 main models that construct the Messanger API and 1 additional model that store each unread message that user has not read yet. For each model and their associations will be explained below:

#### `User` Model 

The `User` is self explanatory and the only model that the challenge provides. The `User` model has 2 main associations which are:

1. `many-to-many` to self `User` model through `Conversation` join model. This association will make sure **only** 2 user model that will connect to one `Conversation` model.
2. `one-to-many` to `Text` model. This explains that each user will have many texts that they will send to other user.

#### `Conversation` Model

The `Conversation` model describes how the application store the information about who is texting to who and what are the chatting about, also additional information about the text status is read or not. There are 3 main associations which are:

1. `many-to-many` to `User` model as a join model to store who is texting to who. This association will store 2 different user`s id. Their representation in this solution can be seen on model description at [conversation.rb](app/models/conversation.rb).
2. `one-to-many` to `Text` model. Besides user, conversation will also store all the text that has been send from both party so `Conversation` model can list all of the texts.
3. `one-to-many` to `Unread` model. All of the unread status will be managed by `Conversation` model and because there are only two user, each user will have `Unread` model. More explanation about `Unread` model will be explained below.

#### `Text` Model

The `Text` model describes what kind of text/message that the user send to other user through their conversation. There is only one association which is:

1. `one-to-one` to `Unread` model. This will describe wheter this text has been read by other user or not.

Thus further, there is a callback function that will run after the creation of `Text` model that will push a new `Unread` entity that will make indirect relation to other user that the text send to. For details look at model desciption at [text.rb](app/models/text.rb)

#### `Unread` Model

The `Unread` model describes the unread status of text to other user the text been send to. This entity will only be created when text model has been created using callback function at `Text` model description.

## References

- [Ruby on Rails Guides](https://guides.rubyonrails.org)
- [Rail JWT and Authentication Example](https://medium.com/binar-academy/rails-api-jwt-authentication-a04503ea3248)
- [Rails ActiveSupport::CurrentAttributes Usage](https://www.mintbit.com/blog/rails-current-attributes-usage-pros-and-cons)
- [Ruby JSON Schema Validator](https://github.com/voxpupuli/json-schema)
- [Intro to Rails Serializers](https://medium.com/@maxfpowell/a-quick-intro-to-rails-serializers-b390ced1fce7)

