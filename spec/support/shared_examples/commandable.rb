RSpec.shared_examples 'active_command/commandable' do
  describe '#command' do
    let(:name) { 'service/model/create' }
    let(:options) { { name: 'test'} }

    it 'enqueue command' do
      expect(ActiveCommand::Backends)
        .to receive(:enqueue)
        .with(name, subject.invoker, options)

      subject.command name, options
    end
  end
end
