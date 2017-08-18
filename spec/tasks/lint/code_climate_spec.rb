require 'rails_helper'

RSpec.describe 'rake lint:codeclimate', type: :task do
  it 'prints install instructions when the CodeClimate CLI is not available' do
    allow(CodeClimateCli).to receive(:available?).and_return(false)
    expect(CodeClimateCli).to receive(:give_install_instructions)

    task.execute
  end

  it 'performs a local CodeClimate analysis when the CLI is available' do
    allow(CodeClimateCli).to receive(:available?).and_return(true)
    expect(CodeClimateCli).to receive(:run)

    task.execute
  end
end
