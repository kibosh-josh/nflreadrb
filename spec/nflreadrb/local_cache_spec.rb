# frozen_string_literal: true

require 'spec_helper'

module Nflreadrb
  RSpec.describe LocalCache do
    describe '.path_for' do
      subject { described_class.path_for(url) }

      let(:url) { 'https://example.com/player_stats.parquet' }
      let(:expected_dir) { File.join(Dir.tmpdir, 'nflreadrb_cache') }
      let(:expected_path) { File.join(expected_dir, 'player_stats.parquet') }

      let(:mock_remote_stream) { instance_double(StringIO, read: 'parquet_binary_payload') }
      let(:mock_local_file) { instance_double(File) }

      before do
        allow(FileUtils).to receive(:mkdir_p).with(expected_dir)
        allow(Dir).to receive(:exist?).with(expected_dir).and_return(true)
        allow(File).to receive(:open).with(expected_path, 'wb').and_yield(mock_local_file)
        allow(mock_local_file).to receive(:write)
      end

      # --- PERMUTATION 1: COLD START ---
      context 'when the cache file does not exist on disk (Cold Start)' do
        before do
          allow(File).to receive(:exist?).with(expected_path).and_return(false)
          allow(URI).to receive(:open).with(url).and_yield(mock_remote_stream)
        end

        it 'automatically creates the directory structure' do
          allow(Dir).to receive(:exist?).with(expected_dir).and_return(false)
          subject
          expect(FileUtils).to have_received(:mkdir_p).with(expected_dir)
        end

        it 'streams data from the network and writes it permanently to the disk layout' do
          expect(subject).to eq(expected_path)
          expect(URI).to have_received(:open).with(url)
          expect(mock_local_file).to have_received(:write).with('parquet_binary_payload')
        end
      end

      context 'when the cache file exists and is fresh (Cache Hit)' do
        let(:now) { Time.local(2026, 5, 21, 12, 0, 0) }
        let(:ten_minutes_ago) { now - 600 }

        before do
          allow(Time).to receive(:now).and_return(now)
          allow(File).to receive(:exist?).with(expected_path).and_return(true)
          allow(File).to receive(:mtime).with(expected_path).and_return(ten_minutes_ago)
          allow(URI).to receive(:open) # No stubbed network returns, should never be reached
        end

        it 'bypasses the external network entirely and resolves immediately' do
          expect(subject).to eq(expected_path)
          expect(URI).not_to have_received(:open)
        end
      end

      context 'when the cache file exists but is stale (Expired)' do
        let(:now) { Time.local(2026, 5, 21, 12, 0, 0) }
        let(:twenty_five_hours_ago) { now - (25 * 60 * 60) }

        before do
          allow(Time).to receive(:now).and_return(now)
          allow(File).to receive(:exist?).with(expected_path).and_return(true)
          allow(File).to receive(:mtime).with(expected_path).and_return(twenty_five_hours_ago)
          allow(URI).to receive(:open).with(url).and_yield(mock_remote_stream)
        end

        it 'detects expiration, forces an overwrite download, and resolves the path' do
          expect(subject).to eq(expected_path)
          expect(URI).to have_received(:open).with(url)
          expect(mock_local_file).to have_received(:write).with('parquet_binary_payload')
        end
      end

      context 'when the file is completely missing and the network stream drops' do
        before do
          allow(File).to receive(:exist?).with(expected_path).and_return(false)
          allow(URI).to receive(:open).with(url).and_raise(OpenURI::HTTPError.new('500 Internal Server Error', nil))
        end

        it 'intercepts the raw HTTP exception and re-raises a descriptive gem error context' do
          expect { subject }.to raise_error(Nflreadrb::Error, /Failed to fetch data from url: #{url}/)
        end
      end
    end
  end
end
