# frozen_string_literal: true

module Nflreadrb
  RSpec.describe WeeklyRosters do
    describe '.load' do
      subject { described_class.load(year:) }

      let(:year) { 2024 }

      context 'default without passing in columns' do
        it 'successfully fetches weekly rosters for a specific year', :integration do
          expect(subject).to be_an(Array)
          expect(subject.length).to eq(46579)

          first_record = subject.first
          expect(first_record['season']).to eq(2024)
          expect(first_record['depth_chart_position']).not_to be_nil
          expect(first_record['jersey_number']).not_to be_nil
        end
      end

      context 'with explicit columns requested' do
        subject { described_class.load(year:, columns:) }

        let(:columns) { [:depth_chart_position, :jersey_number] }

        it 'slices the returned hashes horizontally to contain only the requested keys', :integration do
          expect(subject).to be_an(Array)

          first_record = subject.first
          expect(first_record.key?('depth_chart_position')).to be true
          expect(first_record.key?('jersey_number')).to be true
          expect(first_record.key?('season')).to be false
          expect(first_record.key?('practice_status')).to be false
        end
      end
    end
  end
end