require 'rubygems'

require 'active_support/all'
require 'active_command/version'
require 'active_command/configuration'
require 'active_command/concerns/authorizable'
require 'active_command/concerns/chainable'
require 'active_command/concerns/commandable'
require 'active_command/concerns/combinable'
require 'active_command/concerns/respondable'
require 'active_command/concerns/measurable'
require 'active_command/concerns/validatable'
require 'active_command/base'
require 'active_command/backends'
require 'active_command/responders'

require 'active_command/extender' if defined? ActionController

module ActiveCommand
  class << self
    # Getter for shared global objects
    attr_reader :configuration

    # Returns the global [Configuration](ActiveCommand/Configuration) object.
    #
    # @example
    #     ActiveCommand.configuration.responder = :pusher
    def configuration
      @configuration ||= ActiveCommand::Configuration.new
    end

    # Yields the global configuration to a block.
    # @yield [Configuration] global configuration
    #
    # @example
    #     ActiveCommand.configure do |config|
    #       config.responder = :fayer
    #     end
    def configure
      yield configuration if block_given?

      Backends.create
      Responders.create
    end
  end
end
