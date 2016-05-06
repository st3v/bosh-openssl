require "bosh/openssl"

module Bosh::Cli::Command
  class Password < Base
    include Bosh::Openssl::Helpers

    usage "password"
    desc "Generates random password."

    def perform
      puts password
    end

  end
end

