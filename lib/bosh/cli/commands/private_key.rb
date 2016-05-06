require "bosh/openssl"

module Bosh::Cli::Command
  class PrivateKey < Base
    include Bosh::Openssl::Helpers

    usage "private key"
    desc "Returns named private key. Generates new key if it doesn't already exist."

    def perform(key_name)
      puts private_key(key_name)
    end

  end
end
