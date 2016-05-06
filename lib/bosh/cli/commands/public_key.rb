require "bosh/openssl"

module Bosh::Cli::Command
  class PublicKey < Base
    include Bosh::Openssl::Helpers

    usage "public key"
    desc "Returns named public key. Generates new key if it doesn't already exist."

    def perform(key_name)
      puts public_key(key_name)
    end

  end
end
