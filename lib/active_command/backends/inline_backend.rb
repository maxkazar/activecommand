module ActiveCommand
  module Backends
    class InlineBackend
      class Queue
        def size
          0
        end
      end

      def self.enqueue(*args)
        ActiveCommand::Backends.dequeue *args
      end

      def self.queue(command_name)
        Queue.new
      end
    end
  end
end
