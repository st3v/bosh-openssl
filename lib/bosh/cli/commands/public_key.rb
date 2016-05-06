require "bosh/openssl"

module Bosh::Cli::Command
  class PublicKey < Base
    include Bosh::Openssl::Helpers

    usage "public key"
    desc "Returns named public key. Generates new key if it doesn't already exist."
    option "--no-escape", "don't escape newlines in output"

    def perform(name)
      out = public_key(name).to_s
      out = out.dump unless options[:no_escape] == false
      puts out
    end
  end
end
