require "bosh/openssl"

module Bosh::Cli::Command
  class YamlExtensions < Base

    ::BoshExtensions.module_eval do
      def get_password name
        include ::Bosh::Openssl::Helpers
        password name
      end
      def get_certificate cert_name, key_name, common_name
        include ::Bosh::Openssl::Helpers
        out = certificate(cert_name, key_name, common_name).to_s
        out.dump
      end
      def get_public_key name
        include ::Bosh::Openssl::Helpers
        out = public_key(name).to_s
        out.dump
      end
      def get_private_key name
        include ::Bosh::Openssl::Helpers
        out = private_key(name).to_s
        out.dump.to_s
      end
    end
  end
end