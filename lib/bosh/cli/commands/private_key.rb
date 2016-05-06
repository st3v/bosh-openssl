require "bosh/openssl"

module Bosh::Cli::Command
  class PrivateKey < Base
    include Bosh::Openssl::Helpers

    usage "private key"
    desc "Returns named private key. Generates new key if it doesn't already exist."
    option "--no-escape", "don't escape newlines in output"

    def perform(name)
      out = private_key(name).to_s
      out = out.dump unless options[:no_escape] == false
      puts out
    end
  end
end
