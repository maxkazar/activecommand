require 'spec_helper'
require 'action_controller'
require 'active_command/extender'

RSpec.describe ActiveCommand::Extender do
  let(:extend_class) do
    Class.new do
      include ActiveCommand::Extender
      attr_reader :current_user, :request
    end
  end
  let(:current_user) { double :current_user }

  subject { extend_class.new }

  describe '#command' do
    let(:command) { 'project/create' }
    let(:options) { { name: 'My Project' } }

    before { allow(subject).to receive(:current_user).and_return current_user }

    it 'enqueue command' do
      expect(ActiveCommand::Backends).to receive(:enqueue).with(command, current_user, options: options)
      subject.command command, options
    end
  end
end
