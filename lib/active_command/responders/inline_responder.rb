module ActiveCommand
  module Responders
    module InlineResponder
      def self.respond(*, model)
        model
      end
    end
  end
end
