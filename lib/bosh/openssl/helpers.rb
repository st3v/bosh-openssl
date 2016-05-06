require 'openssl'

module Bosh
  module Openssl
    module Helpers

      def public_key(name)
        private_key(name).public_key
      end

      def private_key(name)
        name += ".key"
        return read_key(name) if exists?(name)

        key = OpenSSL::PKey::RSA.new(2048)
        write(name, key)
        key
      end

      def password
        Base64.encode64(OpenSSL::Random.random_bytes(16))
      end

      def certificate(cert_name, key_name)
        cert_name += ".crt"
        return read_cert(cert_name) if exists?(cert_name)

        cert = sign_certificate(generate_certificate, key_name)
        write(cert_name, cert)
        cert
      end

      private

      SSL_DIR='./.ssl'

      def generate_certificate
        subject = "/C=BE/O=Test/OU=Test/CN=Test"

        cert = OpenSSL::X509::Certificate.new
        cert.subject = cert.issuer = OpenSSL::X509::Name.parse(subject)
        cert.not_before = Time.now
        cert.not_after = Time.now + 10 * 365 * 24 * 60 * 60
        cert.serial = 0x0
        cert.version = 2

        ef = OpenSSL::X509::ExtensionFactory.new
        ef.subject_certificate = cert
        ef.issuer_certificate = cert
        cert.extensions = [
          ef.create_extension("basicConstraints","CA:TRUE", true),
          ef.create_extension("subjectKeyIdentifier", "hash"),
        ]
        cert.add_extension ef.create_extension("authorityKeyIdentifier",
                                               "keyid:always,issuer:always")

        cert
      end

      def sign_certificate(cert, key_name)
        cert.public_key = public_key(key_name)
        cert.sign private_key(key_name), OpenSSL::Digest::SHA1.new
        cert.to_pem
      end

      def read_key(name)
        OpenSSL::PKey::RSA.new File.read(path(name))
      end

      def read_cert(name)
        OpenSSL::X509::Certificate.new File.read(path(name))
      end

      def write(name, payload)
        FileUtils::mkdir_p SSL_DIR
        File.open(path(name), 'w') { |file| file.write(payload) }
      end

      def exists?(name)
        File.exists?(path(name))
      end

      def path(name)
        File.join(SSL_DIR, name)
      end
    end
  end
end
