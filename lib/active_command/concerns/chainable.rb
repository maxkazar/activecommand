module ActiveCommand
  module Chainable
    def chain
      @chain ||= @context[:chain] || []
    end

    def commands(*args)
      options = args.extract_options!
      add_to_chain args
      execute_chain options
    end

    def execute
      super
      execute_chain
    end

    private

    def add_to_chain(commands)
      chain.concat commands
    end

    def execute_chain(options = nil)
      return unless chain.present?

      name = chain.first
      if name.is_a? Array
        name.each { |name| command name, options: options }
      else
        command name, chain: chain[1..-1], options: options
      end
    end
  end
end
