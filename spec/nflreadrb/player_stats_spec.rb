# frozen_string_literal: true

module Nflreadrb
  RSpec.describe PlayerStats do
    describe '.load' do
      subject { described_class.load(year:) }

      let(:year) { 2025 }

      context 'default without passing in columns' do
        it 'successfully fetches and filters player stats by year', :integration do
          expect(subject).to be_an(Array)
          expect(subject.empty?).to be false

          distinct_seasons = subject.map { |row| row['season'] }.uniq
          expect(distinct_seasons).to eq([2025])

          mahomes_records = subject.select { |row| row['player_name'] == 'P.Mahomes' }
          expect(mahomes_records.any?).to be true
        end
      end

      context 'with explicit columns requested' do
        subject { described_class.load(year:, columns:) }

        let(:columns) { [:player_id, :player_name] }

        it 'slices the returned hashes horizontally to contain only the requested keys', :integration do
          expect(subject).to be_an(Array)

          first_record = subject.first
          expect(first_record.key?('player_id')).to be true
          expect(first_record.key?('player_name')).to be true
          expect(first_record.key?('season')).to be false
          expect(first_record.key?('practice_status')).to be false
        end
      end
    end
  end
end