require "mellon"
require "econfig"

module Econfig
  class Keychain
    attr_reader :store

    def initialize(keychain, name)
      @store = ::Mellon::Store.new(name, keychain: keychain)
    end

    def has_key?(key)
      true if store.fetch(key)
    rescue KeyError
      false
    end

    def get(key)
      store[key]
    end

    def set(key, value)
      store[key] = value
    end
  end
end
