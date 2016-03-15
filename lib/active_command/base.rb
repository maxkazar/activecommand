module ActiveCommand

  # Sidekiq Command class. Implements command pattern for Sidekiq.
  # Helps to deconstruct application into micro services with command interface.
  #
  # Command class file structure with two micro services (mailer and users):
  #
  #     app
  #       commands
  #         mailer
  #           deliver_command.rb
  #         users
  #           create_command.rb
  #
  # Command queues will be the following:
  #
  #     mailer
  #     users
  #
  class Base
    prepend Chainable
    prepend Combinable
    prepend Validatable
    prepend Measurable
    prepend Respondable
    prepend Authorizable

    include Commandable

    attr_reader :invoker, :options, :context

    def initialize(invoker, context = {})
      @invoker = invoker
      @context = context.deep_symbolize_keys
      @options = @context[:options] || {}
    end

    def name
      @name ||= self.class.name.underscore.gsub(/_command/, '')
    end

    def execute
    end
  end
end