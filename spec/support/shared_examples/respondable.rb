RSpec.shared_examples 'active_command/respondable' do
  describe '#respond_with' do
    let(:model) { double :model }

    it 'respond with command model' do
      expect(ActiveCommand::Responders)
        .to receive(:respond_with)
        .with(subject.name, subject.invoker, subject.context, model)

      subject.respond_with model
    end
  end
end
