require "bosh/openssl"

module Bosh::Cli::Command
  class PublicKey < Base
    include Bosh::Openssl::Helpers

    usage "public key"
    desc "Returns named public key. Generates new key if it doesn't already exist."

    def perform(name)
      puts public_key(name)
    end

  end
end
