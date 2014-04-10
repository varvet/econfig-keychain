require "mellon"
require "econfig"

module Econfig
  class Keychain
    def initialize(keychain, name: nil)
      name ||= [File.basename(Econfig.root), Econfig.env].join("-")
      @store = ::Mellon::Store.new(name, keychain: keychain)
    end

    def project_name
      @store.project_name
    end

    def keychain
      @store.keychain
    end

    def init
      keychain[project_name] ||= ""
    end

    def get(key)
      @store[key]
    end

    def set(key, value)
      @store[key] = value
    end
  end
end
