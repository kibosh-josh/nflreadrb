# frozen_string_literal: true

module Nflreadrb
  RSpec.describe PlayerStats do
    describe '.load' do
      subject { described_class.load(year:) }

      let(:year) { 2024 }

      it 'successfully fetches and filters player stats by year', :integration do
        expect(subject).to be_an(Array)
        expect(subject.empty?).to be false

        distinct_seasons = subject.map { |row| row['season'] }.uniq
        expect(distinct_seasons).to eq([2024])

        mahomes_records = subject.select { |row| row['player_name'] == 'P.Mahomes' }
        expect(mahomes_records.any?).to be true
      end
    end
  end
end