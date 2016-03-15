module ActiveCommand
  module Commandable
    def command(name, options = {})
      Backends.enqueue name, invoker, options: options
    end

    def backend
      Backends.default
    end
  end
end
