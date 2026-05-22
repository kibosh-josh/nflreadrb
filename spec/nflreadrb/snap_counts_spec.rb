
# frozen_string_literal: true

module Nflreadrb
  RSpec.describe SnapCounts do
    describe '.load' do
      subject { described_class.load(year:) }

      let(:year) { 2024 }

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
  end
end