# frozen_string_literal: true

module Nflreadrb
  RSpec.describe Injuries do
    describe '.load' do
      subject { described_class.load(year:) }

      let(:year) { 2025 }

      context 'default without passing in columns' do
        it 'successfully fetches and parses injury data for a specific year', :integration do
          expect(subject).to be_an(Array)
          expect(subject.length).to eq(6068)

          first_record = subject.first
          expect(first_record['season']).to eq(2025)
          expect(first_record['practice_status']).not_to be_nil
        end
      end

      context 'with explicit columns requested' do
        subject { described_class.load(year:, columns:) }

        let(:columns) { [:game_type, :report_status] }

        it 'slices the returned hashes horizontally to contain only the requested keys', :integration do
          expect(subject).to be_an(Array)

          first_record = subject.first
          expect(first_record.key?('game_type')).to be true
          expect(first_record.key?('report_status')).to be true
          expect(first_record.key?('season')).to be false
          expect(first_record.key?('practice_status')).to be false
        end
      end
    end
  end
end
