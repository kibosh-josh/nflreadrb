# frozen_string_literal: true

module Nflreadrb
  RSpec.describe ParquetLoader do
    describe '.fetch_and_filter' do
      subject { described_class.fetch_and_filter(url:, year:, column_name:) }

      let(:url) { 'https://example.com/nfl_data.parquet' }
      let(:year) { 2024 }
      let(:column_name) { 'season' }

      let(:mock_remote_file) { instance_double(StringIO, read: 'parquet_binary_stream') }
      let(:mock_dataframe) { instance_double(Polars::DataFrame) }
      let(:mock_filtered_dataframe) { instance_double(Polars::DataFrame, to_a: [{ 'season' => 2024, 'player' => 'P.Mahomes' }]) }

      before do
        allow(URI).to receive(:open).with(url).and_yield(mock_remote_file)
        allow(Polars).to receive(:read_parquet).and_return(mock_dataframe)
        allow(Polars).to receive(:col).and_call_original
      end

      context 'when using the default column name' do
        subject { described_class.fetch_and_filter(url:, year:) }

        before do
          allow(mock_dataframe).to receive(:filter).and_return(mock_filtered_dataframe)
        end

        it 'successfully filters by the default season column and returns an array' do
          expect(subject).to eq([{ 'season' => 2024, 'player' => 'P.Mahomes' }])
        end
      end

      context 'with a different year' do
        let(:year) { 2023 }
        let(:mock_filtered_dataframe) { instance_double(Polars::DataFrame, to_a: [{ 'season' => 2023, 'player' => 'L.Jackson' }]) }

        before do
          allow(mock_dataframe).to receive(:filter).and_return(mock_filtered_dataframe)
        end

        it 'dynamically passes the specified year to the filter expression' do
          expect(subject).to eq([{ 'season' => 2023, 'player' => 'L.Jackson' }])
        end
      end

      context 'when overriding with a custom column name' do
        let(:column_name) { 'draft_year' }
        let(:mock_filtered_dataframe) { instance_double(Polars::DataFrame, to_a: [{ 'draft_year' => 2024, 'player' => 'C.Williams' }]) }

        before do
          allow(mock_dataframe).to receive(:filter).and_return(mock_filtered_dataframe)
        end

        it 'overrides the default column and matches against the custom column name' do
          expect(subject).to eq([{ 'draft_year' => 2024, 'player' => 'C.Williams' }])
        end
      end

      context 'when the targeted URL returns a network error' do
        before do
          allow(URI).to receive(:open).with(url).and_raise(OpenURI::HTTPError.new('404 Not Found', nil))
        end

        it 'rescues the exception and raises a custom gem error containing the broken URL' do
          expect { subject }.to raise_error(Nflreadrb::Error, /Failed to fetch data from url: #{url}/)
        end
      end
    end
  end
end