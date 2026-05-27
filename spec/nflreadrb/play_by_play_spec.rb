# frozen_string_literal: true

module Nflreadrb
  RSpec.describe PlayByPlay do
    describe '.load' do
      subject { described_class.load(year:) }

      let(:year) { 2025 }

      context 'default without passing in columns' do
        it 'successfully fetches and parses play by play data for a specific year', :integration do
          expect(subject).to be_an(Array)
          expect(subject.length).to eq(48771)

          first_record = subject.first
          expect(first_record['home_team']).to eq('NO')
          expect(first_record['away_team']).to eq('ARI')
        end
      end

      context 'with explicit columns requested' do
        subject { described_class.load(year:, columns:) }

        let(:columns) { [:game_seconds_remaining, :home_timeouts_remaining] }

        it 'slices the returned hashes horizontally to contain only the requested keys', :integration do
          expect(subject).to be_an(Array)

          first_record = subject.first
          expect(first_record['game_seconds_remaining']).to eq(3600.0)
          expect(first_record['home_timeouts_remaining']).to eq(3)
          expect(first_record.key?('home_team')).to be false
          expect(first_record.key?('away_team')).to be false
        end
      end
    end
  end
end
