module ActiveCommand
  module Backends
    autoload :InlineBackend, 'active_command/backends/inline_backend'
    autoload :SidekiqBackend, 'active_command/backends/sidekiq_backend'

    class << self
      attr_reader :default

      def create
        @default = "ActiveCommand::Backends::#{backend.to_s.classify}Backend".constantize
      rescue NameError
        raise ArgumentError, "Unsupported backend #{backend} for active command."
      end

      def enqueue(name, invoker, *args)
        default.enqueue name, serialize(invoker), *args
      end

      def dequeue(name, invoker, *args)
        command = create_command name, deserialize(invoker), *args
        command.execute if command.can_execute?
      end

      private

      def backend
        ActiveCommand.configuration.backend
      end

      def serialize(invoker)
        [invoker.class.name, invoker.id.to_s]
      end

      def deserialize(invoker)
        invoker[0].constantize.find invoker[1]
      end

      def create_command(name, invoker, *args)
        "#{name.classify}Command".constantize.new invoker, *args
      rescue NameError
        raise ArgumentError, "Unsupported command #{name} for active command."
      end
    end
  end
end
