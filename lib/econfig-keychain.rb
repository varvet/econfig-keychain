require "econfig/keychain"

module Econfig
  class << self
    def use_keychain(keychain, **kwargs)
      Econfig.instance.backends << Econfig::Keychain.new(keychain, **kwargs)
    end
  end
end
