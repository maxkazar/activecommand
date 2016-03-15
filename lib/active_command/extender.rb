module ActiveCommand
  module Extender
    def command(name, options)
      context = { options: options }

      ActiveCommand::Responders.init context, request
      ActiveCommand::Backends.enqueue name, current_user, context
    end
  end
end

ActionController::Base.include ActiveCommand::Extender
