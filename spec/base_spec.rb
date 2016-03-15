require 'spec_helper'

RSpec.describe ActiveCommand::Base do
  let(:invoker) { Invoker.new }

  subject { ActiveCommand::Base.new invoker }

  it_behaves_like 'active_command/chainable'
  it_behaves_like 'active_command/validatable'
  it_behaves_like 'active_command/respondable'
  it_behaves_like 'active_command/authorizable'
  it_behaves_like 'active_command/commandable'
  it_behaves_like 'active_command/combinable'
end
