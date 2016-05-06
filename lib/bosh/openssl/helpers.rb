require 'openssl'

module Bosh
  module Openssl
    module Helpers

      def public_key(key_name)
        private_key(key_name).public_key
      end

      def private_key(key_name)
        return read_key(key_name) if key_exists?(key_name)

        key = OpenSSL::PKey::RSA.new(2048)
        write_key(key_name, key)
        key
      end

      private

      KEY_DIR='./.ssl'

      def read_key(key_name)
        OpenSSL::PKey::RSA.new File.read(key_path(key_name))
      end

      def write_key(key_name, key)
        FileUtils::mkdir_p KEY_DIR
        File.open(key_path(key_name), 'w') { |file| file.write(key) }
      end

      def key_exists?(key_name)
        File.exists?(key_path(key_name))
      end

      def key_path(key_name)
        File.join(KEY_DIR, key_name)
      end

    end
  end
end
