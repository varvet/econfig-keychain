require "mellon"
require "econfig"

module Econfig
  class Keychain
    def initialize(keychain, name: nil)
      name ||= [File.basename(Econfig.root), Econfig.env].join("-")
      @store = ::Mellon::Store.new(name, keychain: keychain)
    end

    def get(key)
      @store[key]
    end

    def set(key, value)
      @store[key] = value
    end
  end
end
