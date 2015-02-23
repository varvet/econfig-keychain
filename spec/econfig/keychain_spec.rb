$stderr.puts "If asked for a password, the password is empty. Just press OK."

require "econfig-keychain"

Econfig.root = __dir__
Econfig.env = "test"

describe Econfig::Keychain do
  let(:keychain_path) { File.expand_path("./osx.temporary.keychain", __dir__) }
  let(:keychain) { Mellon::Keychain.new(keychain_path) }
  let(:item_name) { "econfig" }
  let(:backend) { Econfig::Keychain.new(keychain, item_name) }

  around do |example|
    original_keychain_path = File.expand_path("./osx.keychain", __dir__)
    FileUtils.cp(original_keychain_path, keychain_path)
    example.run
    FileUtils.rm(keychain_path)
  end

  describe "#initialize" do
    let(:item_name) { "other" }

    it "creates the keychain note if it does not exist" do
      backend.set("foo", "bar")
      YAML.load(keychain["other"])["foo"].should eq("bar")
    end
  end

  describe "#has_key?" do
    it "returns false if the option does not exist" do
      backend.has_key?("does not exist").should eq false
    end

    it "returns true if the option exists" do
      backend.has_key?("i exist").should eq true
    end
  end

  describe "#get" do
    it "fetches an option from the keychain" do
      backend.get("i exist").should eq "this exist"
    end

    it "returns nil if option does not exist" do
      backend.get("does not exist").should be_nil
    end
  end

  describe "#set" do
    it "sets an option in the keychain" do
      backend.set("new key", "pub")
      backend.get("new key").should eq "pub"
    end

    it "does not overwrite existing data" do
      backend.set("a", "foo")
      backend.set("b", "bar")
      backend.get("a").should eq "foo"
      backend.get("b").should eq "bar"
    end
  end
end
