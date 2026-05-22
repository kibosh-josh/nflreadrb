# frozen_string_literal: true

module Nflreadrb
  RSpec.describe Nflreadrb do
    let(:year) { 2024 }

    it 'has a version number' do
      expect(Nflreadrb::VERSION).not_to be nil
    end

    describe '.load_player_stats', :integration do
      subject { described_class.load_player_stats(year:) }

      before { allow(PlayerStats).to receive(:load).with(year:).and_call_original }


      it 'delegates to the PlayerStats engine' do
        expect(subject).to be_an(Array)
        expect(subject.length).to eq(5597)
        expect(PlayerStats).to have_received(:load).exactly(1).time.with(year: 2024)
      end
    end

    describe '.load_rosters', :integration do
      subject { described_class.load_rosters(year:) }

      before { allow(WeeklyRosters).to receive(:load).with(year:).and_call_original }

      it 'delegates to the WeeklyRosters engine' do
        expect(subject).to be_an(Array)
        expect(subject.length).to eq(46579)
        expect(WeeklyRosters).to have_received(:load).exactly(1).time.with(year: 2024)
      end
    end

    describe '.load_injuries', :integration do
      subject { described_class.load_injuries(year:) }

      before { allow(Injuries).to receive(:load).with(year:).and_call_original }

      it 'delegates to the Injuries engine' do
        expect(subject).to be_an(Array)
        expect(subject.length).to eq(6215)
        expect(Injuries).to have_received(:load).exactly(1).time.with(year: 2024)
      end
    end

    describe '.load_schedules', :integration do
      subject { described_class.load_schedules(year:) }

      before { allow(Schedules).to receive(:load).with(year:).and_call_original }

      it 'delegates to the Schedules engine' do
        expect(subject).to be_an(Array)
        expect(subject.length).to eq(285)
        expect(Schedules).to have_received(:load).exactly(1).time.with(year: 2024)
      end
    end

    describe '.load_snap_counts', :integration do
      subject { described_class.load_snap_counts(year:) }

      before { allow(SnapCounts).to receive(:load).with(year:).and_call_original }

      it 'delegates to the SnapCounts engine' do
        expect(subject).to be_an(Array)
        expect(subject.length).to eq(26615)
        expect(SnapCounts).to have_received(:load).exactly(1).time.with(year: 2024)
      end
    end
  end
end