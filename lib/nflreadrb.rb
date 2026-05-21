# frozen_string_literal: true

require 'open-uri'
require 'tempfile'
require 'polars'
require_relative "nflreadrb/version"

module Nflreadrb
  class Error < StandardError; end

  DATA_URL = "https://github.com/nflverse/nflverse-data/releases/download/player_stats/player_stats.parquet"

  def self.load_player_stats
    Tempfile.create(["nfl_player_stats", ".parquet"]) do |temp_file|
      temp_file.binmode

      # Stream the binary parquet file down from GitHub
      URI.open(DATA_URL) do |remote_file|
        temp_file.write(remote_file.read)
      end
      temp_file.rewind

      # Polars parses the parquet file natively
      df = Polars.read_parquet(temp_file.path)

      # Converts the entire dataframe into a clean array of Ruby hashes
      df.to_a
    end
  end
end
