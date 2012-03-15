# How To Use

In your data model:

```ruby
require 'mince_data_model'

class TronLightCycleDataModel
  include MinceDataModel
  
  # Name of the collection or table to store the data
  data_collection :light_cycles
  
  # The fields or columns this data model can have
  data_fields :luminating_color, :rezzed, :jetwall, :grid_locked
end
```

# What Iz Mince Data Model?

Some niceties and defines an implementation to swap out different data persistance strategies.  Currently there are 2 supported data persistance strategies: Mince (MongoDB), and HashyDB (in memory hash). If using this gem, all you need to do in order to change the data persistence strategy is to implement the methods outlined by this gem.  Check out the [Mince Data Store](https://github.com/asynchrony/mince/blob/master/lib/mince/data_store.rb) and the [HashyDB Data Store](https://github.com/asynchrony/HashyDB/blob/master/lib/hashy_db/data_store.rb) for a list of methods to implement.

# Why?

A little background perhaps...

After developing quite a few Rails apps, we started feeling a lot of pain with our models.  I'm sure most of us know this pain.  We end up having *at least one* **massive** model which ends up being the brain model of the application.  Generally this model is the User model, or the Project model.  Whichever class your application primarily focusses on.

After some time of trying new things and talking to others, reading from others, and evolving our applications, the source of the problem seemed to be the Active Record architecture pattern.  Where logic and data are presented as a unified package.  The problem with that is that there is a **ton** of logic that can be associated to a very *little* bit of data.

The idea behind the mince is to provide the lightest weight ORM possible so that you can build your application's business logic and data logic completely isolated from each other.

One great example is the user model. Every app on the face of the uniwebs has it and we can all relate to it. First, you need to register.  Registration has validations.  Once you've registered, you need to confirm your email before you can login.  Once you login you want to change information about yourself.  But since you've already created an account, there are different validations than when you were registering!  The validations alone make the User model very complex.  You end up with a lot of conditional logic in your user models.  After you've implemented registration, your user model has already become over 100 lines long!

What if you could have a separate model for **each** logical event?  A registration model, a password updator model, a user account model? Your validations can become specific to one scenario. With this implementation, every class is less than 100 lines long.  Now, number of lines is not our goal, but it is a great indicator to how much that class is doing.

Form more info about the inspiration behind Mince Data Store:

- [Uncle Bob Martin's Ruby Midwest 2011 talk](http://confreaks.com/videos/759-rubymidwest2011-keynote-architecture-the-lost-years)
- [Avdi Grimm's Objects On Rails book](http://devblog.avdi.org/2011/11/15/early-access-beta-of-objects-on-rails-now-available-2/)
- [Working with guys at Asynchrony](http://asynchrony.com)

# Rails Implementation Example

[This mince rails example application](https://github.com/coffeencoke/mince_rails_example) is available to reveal A way to implement the use of the Mince Data Store, [Mince](https://github.com/asynchrony/mince), and [Hashy Db](https://github.com/asynchrony/hashy_db) gems.

# Mince

Mince is a lightweight MongoDB ORM for Ruby.  It frees you from using a huge ORM that forces you into using a specific architecture.  

[@github](https://github.com/asynchrony/mince)
[@rubygems](https://rubygems.org/gems/mince)

# Hashy Db

Provides an interface for storing and retreiving information in a Hash in memory.

The motivation behind this is so you can clone the repository down, have ruby installed, run bundle install and be able to run your tests and develop without being dependent on any other setup.

[@github](https://github.com/asynchrony/hashy_db)
[@rubygems](https://rubygems.org/gems/hashy_db)
