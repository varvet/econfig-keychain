require "econfig/keychain"

module Econfig
  class << self
    def use_keychain(keychain)
      Econfig.instance.backends << Econfig::Keychain.new(keychain)
    end
  end
end
