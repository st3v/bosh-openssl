require "bosh/openssl"

module Bosh::Cli::Command
  class Certificate < Base
    include Bosh::Openssl::Helpers

    usage "certificate"
    desc "Returns a named self-signed certificate. Generates and signes a new cert if it doesn't already exist."
    option "--include-key", "include private key in output"
    option "--no-escape", "don't escape newlines in output"
    option "--cn <common-name>", String, "common name for certificate"

    def perform(cert_name, key_name)
      out = certificate(cert_name, key_name, options[:common_name]).to_s
      out += private_key(key_name).to_s if options[:include_key]
      out = out.dump unless options[:no_escape] == false
      puts out
    end
  end
end


