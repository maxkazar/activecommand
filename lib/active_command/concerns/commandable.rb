module ActiveCommand
  module Commandable
    def command(name, context = {})
      Backends.enqueue name, invoker, @context.merge(context)
    end

    def backend
      Backends.default
    end
  end
end
