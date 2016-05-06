require 'openssl'

module Bosh
  module Openssl
    module Helpers

      def public_key(name)
        private_key(name).public_key
      end

      def private_key(name)
        return read_key(name) if key_exists?(name)

        key = OpenSSL::PKey::RSA.new(2048)
        write_key(name, key)
        key
      end

      def password
        Base64.encode64(OpenSSL::Random.random_bytes(16))
      end

      private

      SSL_DIR='./.ssl'

      def read_key(name)
        OpenSSL::PKey::RSA.new File.read(key_path(name))
      end

      def write_key(name, key)
        FileUtils::mkdir_p SSL_DIR
        File.open(key_path(name), 'w') { |file| file.write(key) }
      end

      def key_exists?(name)
        File.exists?(key_path(name))
      end

      def key_path(name)
        File.join(SSL_DIR, name)
      end

    end
  end
end
