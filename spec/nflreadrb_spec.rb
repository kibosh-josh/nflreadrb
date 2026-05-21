# frozen_string_literal: true

RSpec.describe Nflreadrb do
  it "has a version number" do
    expect(Nflreadrb::VERSION).not_to be nil
  end

  it "successfully fetches and parses player stats from nflverse", :integration do
    puts "Streaming player stats parquet file from GitHub..."
    stats = Nflreadrb.load_player_stats

    expect(stats).to be_an(Array)
    expect(stats.empty?).to be false

    # 🔍 DEBUG LINES: Let's see what Polars gave us
    puts "--- DATA DIAGNOSTIC ---"
    puts "Available Columns (Keys): #{stats.first.keys}"
    puts "Sample Row Data: #{stats.first}"
    puts "-----------------------"

    # Let's find Patrick Mahomes' stats in the dataset to prove it works
    mahomes_records = stats.select { |row| row["player_name"] == "P.Mahomes" }

    puts mahomes_records
  end
end
