[HEAD][]
--------

[v1.0.1][]
----------

- Default project name no longer includes environment [257ee981]

  If you wish to use the old naming, define the name explicitly as such:

  ```
  Econfig.instance.backends << Econfig::Keychain.new("thanks-a-latte", name: "myproject-development")
  ```

[v1.0.0][]
----------

Initial release!

[HEAD]: https://github.com/elabs/econfig-keychain/compare/v1.0.1...HEAD
[v1.0.1]: https://github.com/elabs/econfig-keychain/compare/v1.0.0...v1.0.1
[v1.0.0]: https://github.com/elabs/econfig-keychain/compare/f877fd49...v1.0.0
