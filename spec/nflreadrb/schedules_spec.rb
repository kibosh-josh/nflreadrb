# frozen_string_literal: true

module Nflreadrb
  RSpec.describe Schedules do
    describe '.load' do
      subject { described_class.load(year:) }

      let(:year) { 2024 }

      context 'default without passing in columns' do
        it 'successfully fetches and parses schedule data for a specific year', :integration do
          expect(subject).to be_an(Array)
          expect(subject.length).to eq(285)

          first_record = subject.first
          expect(first_record['season']).to eq(2024)
          expect(first_record['game_id']).not_to be_nil
          expect(first_record['home_team']).not_to be_nil
          expect(first_record['away_team']).not_to be_nil
        end
      end

      context 'with explicit columns requested' do
        subject { described_class.load(year:, columns:) }

        let(:columns) { [:game_id, :game_type] }

        it 'slices the returned hashes horizontally to contain only the requested keys', :integration do
          expect(subject).to be_an(Array)

          first_record = subject.first
          expect(first_record.key?('game_id')).to be true
          expect(first_record.key?('game_type')).to be true
          expect(first_record.key?('season')).to be false
          expect(first_record.key?('practice_status')).to be false
        end
      end
    end
  end
end