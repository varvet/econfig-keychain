$stderr.puts "If asked for a password, the password is empty. Just press OK."

require "econfig-keychain"

Econfig.root = __dir__
Econfig.env = "test"

describe Econfig::Keychain do
  let(:keychain_path) { File.expand_path("./osx.temporary.keychain", __dir__) }
  let(:keychain) { Mellon::Keychain.new(keychain_path) }
  let(:project_name) { File.basename(Econfig.root) }
  let(:backend) { Econfig::Keychain.new(keychain) }

  around do |example|
    original_keychain_path = File.expand_path("./osx.keychain", __dir__)
    FileUtils.cp(original_keychain_path, keychain_path)
    example.run
    FileUtils.rm(keychain_path)
  end

  describe "#init" do
    it "creates the note in the keychain if it does not exist" do
      Econfig.stub(root: "different")
      expect { backend.init }.to change { keychain[project_name] }
        .from(nil).to("")
    end

    it "does not overwrite existing data" do
      backend.init
      backend.get("i exist").should eq "this exist"
    end
  end

  context "before init" do
    specify "#get raises an error" do
      expect { backend.get("key") }.to raise_error(Econfig::UninitializedError)
    end

    specify "#set raises an error" do
      expect { backend.set("key", "value") }.to raise_error(Econfig::UninitializedError)
    end
  end

  context "after init" do
    before { backend.init }

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
    end
  end
end
