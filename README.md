# Missile
Welcome to Missile!

This wonderful ruby gem is a CLI tool that lets you quickly and easily specify project deployments.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'Missile'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install Missile

## Usage
#### Setup a deployment config
So in order to run deployments you will need to setup a deployment config. To do this simply run the following
```
missile setup ['deployment config name']
```
During setup you will be prompted to enter 5 pieces of information
  * host
  * username
  * password
  * local path (path to the project on your machine)
  * remote path (path to where the project will live on the remote location)
  * port number (port number used to access your server *if you are using default leave blank*)
After you enter all of that information your deployment config will be saved

#### Delete a deployment config
To delete a deployment config you have created you run the setup command with the *-d* flag
```
missile setup ['deployment config name'] -d
```

#### Viewing deployment configs
To view all of the available deployment configs you have run the following:
```
missile list
```
This will return the names of all of the available deployment configs you have

#### Viewing a single deployment configs details
If you want to view the specifics of a deployment config run list command with the *-i* flag
```
missile list ['deployment config name'] -i
```

#### Deploying
To deploy your project all you need to do is run the following:
```
missile deploy ['deployment config name']
```
This will take execute deployment based on what you have set in your deployment config


## Development


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ddymko/Missile.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
