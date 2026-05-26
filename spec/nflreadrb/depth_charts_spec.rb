# frozen_string_literal: true

module Nflreadrb
  RSpec.describe DepthCharts do
    describe '.load' do
      subject { described_class.load(year:) }

      let(:year) { 2025 }

      context 'default without passing in columns' do
        it 'successfully fetches and parses injury data for a specific year', :integration do
          expect(subject).to be_an(Array)
          expect(subject.length).to eq(554215)

          first_record = subject.first
          expect(first_record['team']).to eq('ARI')
          expect(first_record['player_name']).to eq('Josh Sweat')
        end
      end

      context 'with explicit columns requested' do
        subject { described_class.load(year:, columns:) }

        let(:columns) { [:player_name, :pos_name] }

        it 'slices the returned hashes horizontally to contain only the requested keys', :integration do
          expect(subject).to be_an(Array)

          first_record = subject.first
          expect(first_record.key?('player_name')).to be true
          expect(first_record.key?('pos_name')).to be true
          expect(first_record.key?('team')).to be false
          expect(first_record.key?('gsis_id')).to be false
        end
      end
    end
  end
end
