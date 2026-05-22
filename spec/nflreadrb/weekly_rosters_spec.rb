# frozen_string_literal: true

module Nflreadrb
  RSpec.describe WeeklyRosters do
    describe '.load' do
      subject { described_class.load(year:) }

      let(:year) { 2024 }

      it 'successfully fetches weekly rosters for a specific year', :integration do
        expect(subject).to be_an(Array)
        expect(subject.empty?).to be false
        expect(subject.first.key?('position')).to be true
      end
    end
  end
end