# frozen_string_literal: true

module Nflreadrb
  RSpec.describe Injuries do
    describe '.load' do
      subject { described_class.load(year:) }

      let(:year) { 2024 }

      it 'successfully fetches and parses injury data for a specific year', :integration do
        expect(subject).to be_an(Array)
        expect(subject.length).to eq(6215)

        first_record = subject.first
        expect(first_record['season']).to eq(2024)
        expect(first_record['report_status']).not_to be_nil
        expect(first_record['practice_status']).not_to be_nil
      end
    end
  end
end