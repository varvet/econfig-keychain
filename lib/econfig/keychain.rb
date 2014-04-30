require "mellon"
require "econfig"

module Econfig
  class Keychain
    def initialize(keychain, name: nil)
      @init = { keychain: keychain, name: name }
    end

    def init
      project_name = @init[:name] || File.basename(Econfig.root)
      @store = ::Mellon::Store.new(project_name, keychain: @init[:keychain])
      @store.keychain[@store.project_name] ||= ""
    end

    def get(key)
      store[key]
    end

    def set(key, value)
      store[key] = value
    end

    private

    def store
      @store or raise Econfig::UninitializedError
    end
  end
end
