require "bosh/openssl"

module Bosh::Cli::Command
  class Password < Base
    include Bosh::Openssl::Helpers

    usage "password <name>"
    desc "Generates random password."

    def perform(name)
      puts password name
    end
  end
end

