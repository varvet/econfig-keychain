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
clever like `thanks-a-latte`. Within `config/initializers/econfig.rb` write the
following:

``` ruby
MyApp.extend Econfig::Shortcut

if Rails.env.development?
  Econfig.use_keychain "thanks-a-latte"
end
```

That's it!  You can change your configuration from the Rails console:

``` ruby
MyApp.aws_access_key_id = "xyz"
```

You can also edit your configuration manually using the Mellon CLI:

```
bundle exec mellon edit myapp
```

# License

MIT. See LICENSE.
