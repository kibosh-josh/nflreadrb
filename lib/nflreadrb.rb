# frozen_string_literal: true

require "open-uri"
require "tempfile"
require "polars"
require_relative "nflreadrb/version"

module Nflreadrb
  class Error < StandardError; end

  DATA_URL = "https://github.com/nflverse/nflverse-data/releases/download/player_stats/player_stats.parquet"

  # Update: Accept a year parameter, defaulting to the previous season
  def self.load_player_stats(year = Time.now.year - 1)
    Tempfile.create(["nfl_player_stats", ".parquet"]) do |temp_file|
      temp_file.binmode

      URI.open(DATA_URL) do |remote_file|
        temp_file.write(remote_file.read)
      end
      temp_file.rewind

      df = Polars.read_parquet(temp_file.path)

      # Use Polars to filter the dataframe rows where the "season" column matches the year
      filtered_df = df.filter(Polars.col("season") == year.to_i)

      filtered_df.to_a
    end
  end
end