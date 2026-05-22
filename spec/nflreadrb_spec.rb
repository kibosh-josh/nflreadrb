# frozen_string_literal: true

module Nflreadrb
  RSpec.describe Nflreadrb do
    it 'has a version number' do
      expect(Nflreadrb::VERSION).not_to be nil
    end

    describe '.load_player_stats', :integration do
      subject { described_class.load_player_stats(year:) }

      let(:year) { 2024 }

      before { allow(PlayerStats).to receive(:load).with(year:).and_call_original }


      it 'delegates to the PlayerStats engine' do
        expect(subject).to be_an(Array)
        expect(subject.length).to eq(5597)
        expect(PlayerStats).to have_received(:load).exactly(1).time.with(year: 2024)
      end
    end

    describe '.load_rosters', :integration do
      subject { described_class.load_rosters(year:) }

      let(:year) { 2024 }

      before { allow(WeeklyRosters).to receive(:load).with(year:).and_call_original }

      it 'delegates to the WeeklyRosters engine' do
        expect(subject).to be_an(Array)
        expect(subject.length).to eq(46579)
        expect(WeeklyRosters).to have_received(:load).exactly(1).time.with(year: 2024)
      end
    end
  end
end