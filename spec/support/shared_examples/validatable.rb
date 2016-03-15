RSpec.shared_examples 'active_command/validatable' do
  describe '#execute' do
    it 'validate' do
      expect(subject).to receive(:validate!)
      subject.execute
    end
  end
end