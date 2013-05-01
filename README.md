# Multiple USCIS Status Checker

This simple website allows you to check multiple application statuses at once. It uses the gem I created that scraps the USCIS website: [USCIS Status Checker](https://github.com/gguerini/uscis_status).

[http://uscisstatus.herokuapp.com](http://uscisstatus.herokuapp.com)

## Installation

Assuming you have Ruby 1.9.2+ with Bundler gem installed:

    $ bundle install
    $ bundle exec rake db:migrate
    $ rails s

    gem 'uscis_status'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install uscis_status

## Important

This is not the official way to check the status of a USCIS application and it's not endorsed by USCIS either. This website DOESN'T guarantee the information is valid and updated. Use at your own risk.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
