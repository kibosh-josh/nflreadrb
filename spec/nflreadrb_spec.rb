# frozen_string_literal: true

module Nflreadrb
  RSpec.describe Nflreadrb do
    it 'has a version number' do
      expect(Nflreadrb::VERSION).not_to be nil
    end

    describe 'Architectural Guardrails' do
      it 'enforces information hiding by keeping the constructor private on domain loaders' do
        expect { BaseLoader.new(year: 2024, columns: nil) }.to raise_error(NoMethodError)
        expect { Injuries.new(year: 2024, columns: nil) }.to raise_error(NoMethodError)
        expect { PlayerStats.new(year: 2024, columns: nil) }.to raise_error(NoMethodError)
        expect { Schedules.new(year: 2024, columns: nil) }.to raise_error(NoMethodError)
        expect { SnapCounts.new(year: 2024, columns: nil) }.to raise_error(NoMethodError)
        expect { WeeklyRosters.new(year: 2024, columns: nil) }.to raise_error(NoMethodError)
      end
    end

    describe '.load_player_stats' do
      subject { described_class.load_player_stats(year:) }

      let(:year) { 2024 }

      context 'default without passing in columns' do
        it 'successfully fetches and parses player stats data for a specific year', :integration do
          expect(subject).to be_an(Array)
          expect(subject.length).to eq(5597)

          first_record = subject.first
          expect(first_record['season']).to eq(2024)
          expect(first_record['player_id']).not_to be_nil
          expect(first_record['passing_yards']).not_to be_nil
        end
      end

      context 'with explicit columns requested' do
        subject { described_class.load_player_stats(year:, columns:) }

        let(:columns) { [:player_id, :passing_yards] }

        it 'slices the returned hashes horizontally to contain only the requested keys', :integration do
          expect(subject).to be_an(Array)

          first_record = subject.first
          expect(first_record.key?('player_id')).to be true
          expect(first_record.key?('passing_yards')).to be true
          expect(first_record.key?('season')).to be false
          expect(first_record.key?('rushing_yards')).to be false
        end
      end
    end

    describe '.load_rosters' do
      subject { described_class.load_rosters(year:) }

      let(:year) { 2024 }

      context 'default without passing in columns' do
        it 'successfully fetches and parses weekly roster data for a specific year', :integration do
          expect(subject).to be_an(Array)
          expect(subject.length).to eq(46579)

          first_record = subject.first
          expect(first_record['season']).to eq(2024)
          expect(first_record['gsis_id']).not_to be_nil
          expect(first_record['full_name']).not_to be_nil
        end
      end

      context 'with explicit columns requested' do
        subject { described_class.load_rosters(year:, columns:) }

        let(:columns) { [:gsis_id, :full_name] }

        it 'slices the returned hashes horizontally to contain only the requested keys', :integration do
          expect(subject).to be_an(Array)

          first_record = subject.first
          expect(first_record.key?('gsis_id')).to be true
          expect(first_record.key?('full_name')).to be true
          expect(first_record.key?('season')).to be false
          expect(first_record.key?('position')).to be false
        end
      end
    end

    describe '.load_injuries' do
      subject { described_class.load_injuries(year:) }

      let(:year) { 2024 }

      context 'default without passing in columns' do
        it 'successfully fetches and parses injury data for a specific year', :integration do
          expect(subject).to be_an(Array)
          expect(subject.length).to eq(6215)

          first_record = subject.first
          expect(first_record['season']).to eq(2024)
          expect(first_record['report_status']).not_to be_nil
          expect(first_record['practice_status']).not_to be_nil
        end
      end

      context 'with explicit columns requested' do
        subject { described_class.load_injuries(year:, columns:) }

        let(:columns) { [:full_name, :report_status] }

        it 'slices the returned hashes horizontally to contain only the requested keys', :integration do
          expect(subject).to be_an(Array)

          first_record = subject.first
          expect(first_record.key?('full_name')).to be true
          expect(first_record.key?('report_status')).to be true
          expect(first_record.key?('season')).to be false
          expect(first_record.key?('practice_status')).to be false
        end
      end
    end

    describe '.load_schedules' do
      subject { described_class.load_schedules(year:) }

      let(:year) { 2024 }

      context 'default without passing in columns' do
        it 'successfully fetches and parses schedule data for a specific year', :integration do
          expect(subject).to be_an(Array)
          expect(subject.length).not_to be_zero

          first_record = subject.first
          expect(first_record['season']).to eq(2024)
          expect(first_record['game_id']).not_to be_nil
          expect(first_record['home_team']).not_to be_nil
        end
      end

      context 'with explicit columns requested' do
        subject { described_class.load_schedules(year:, columns:) }

        let(:columns) { [:game_id, :home_team] }

        it 'slices the returned hashes horizontally to contain only the requested keys', :integration do
          expect(subject).to be_an(Array)

          first_record = subject.first
          expect(first_record.key?('game_id')).to be true
          expect(first_record.key?('home_team')).to be true
          expect(first_record.key?('season')).to be false
          expect(first_record.key?('away_team')).to be false
        end
      end
    end

    describe '.load_snap_counts' do
      subject { described_class.load_snap_counts(year:) }

      let(:year) { 2024 }

      context 'default without passing in columns' do
        it 'successfully fetches and parses snap count data for a specific year', :integration do
          expect(subject).to be_an(Array)
          expect(subject.length).to eq(26615)

          first_record = subject.first
          expect(first_record['season']).to eq(2024)
          expect(first_record['game_id']).not_to be_nil
          expect(first_record['pfr_player_id']).not_to be_nil
          expect(first_record['offense_snaps']).not_to be_nil
        end
      end

      context 'with explicit columns requested' do
        subject { described_class.load_snap_counts(year:, columns:) }

        let(:columns) { [:game_id, :game_type] }

        it 'slices the returned hashes horizontally to contain only the requested keys', :integration do
          expect(subject).to be_an(Array)

          first_record = subject.first
          expect(first_record.key?('game_id')).to be true
          expect(first_record.key?('game_type')).to be true
          expect(first_record.key?('season')).to be false
          expect(first_record.key?('offense_snaps')).to be false
        end
      end
    end
  end
end