require "cli/core_ext"
require "cli/validation"

module Bosh
  module Openssl
    include BoshExtensions
  end
end

require "bosh/openssl/helpers"
require "bosh/openssl/version"
require "bosh/cli/commands/private_key"
require "bosh/cli/commands/public_key"
