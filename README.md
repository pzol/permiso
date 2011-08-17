CSS: http://hotx.resfinity.com/css/readme.css

# Permiso
is a lightweight gem for defining and veryfying permissions, or in other words checking authorization.


Define a class with your abilities, you can name it whatever you want, but Ability is a nice name I borrowed from [cancan](https://github.com/ryanb/cancan).

## Installation
Choose your weapon, via command line

    gem install permiso

in a `Gemfile`

    gem 'permiso'                                               # latest stable
    gem 'permiso', :git => 'git://github.com/pzol/permiso.git'  # for the bleeding edge


## Permiso helper methods

* **role**: defines what a named role can do
* **rule**: defines additional checks which must be met in order 

## The easy example

    class Ability
      include Permiso::Ability
      
      def initialize
        role :admin do
          can :delete
        end
      end
    end

Checking now is easy:

    ability = Ability.new
    ability.can? :admin, :delete

## Example with rules
A more complex example with rules and a domain object injected

    class Ability
      include Permiso::Ability

      def initialize(booking)
        @booking = booking

        role :admin do
          can :cancel
          can :create
        end

        rule :cancel do
          @booking.status == 'book_confirmed'
        end
      end

    end

Checking is (almost) the same as in the prior example:

    ability = Ability.new(booking)
    ability.can? :admin, :cancel

Multiple roles are also supported:

    ability = Ability.new(booking)
    ability.can? [:admin, :user], :cancel

In this case, only the admin can cancel the booking, if the status is book_confirmed.

I use dependency injection, to bring in an object on which I conduct test, in this case the booking.

## Using in Padrino
For that I define a helper

    MyWebApp.helpers do
      def can(action)
        ability = Ability.new(@booking)
        ability.can? current_user.roles, action
      end
    end

which then allows me to use this in my `haml` file:

    - if can :cancel
      %a{ :href => '/cancel' }


## TODO
* blocks for #can (defining)
* role priorities?

