# Econfig::Keychain

An OSX keychain adapter for [Econfig](http://github.com/elabs/econfig), using [Mellon](https://github.com/elabs/mellon).

## Usage with Rails

For OSX, during development only.

First, add econfig-keychain to your Gemfile:

``` ruby
gem "econfig", require: "econfig/rails"
gem "econfig-keychain"
```

Second, create a keychain you wish to store configuration in, name it something
clever like `thanks-a-latte`. Within `config/application.rb` write the following:

``` ruby
module MyApp
  extend Econfig::Shortcut

  if Rails.env.development?
    Econfig.backends.use :keychain, Econfig::Keychain.new("thanks-a-latte")
  end

  class Application < Rails::Application
    # … rest of the configuration
  end
```

That's it!

Econfig::Keychain will automatically create an empty secure note using the name of the directory your project is located at, in the `thanks-a-latte` keychain. If you wish to specify the name yourself, you can do so:

``` ruby
Econfig.backends.use :keychain, Econfig::Keychain.new("thanks-a-latte", name: "project name")
```

## Changing configuration

Econfig::Keychain supports changing configuration by setting values, e.g. from the Rails console:

``` ruby
MyApp.config[:keychain, :aws_access_key_id] = "xyz"
```

You can also edit your configuration with your `$EDITOR` manually using the Mellon CLI:

```
bundle exec mellon edit myapp
```

Finally, you can also edit the keychain entry manually using Keychain Access.

# License

MIT. See LICENSE.
