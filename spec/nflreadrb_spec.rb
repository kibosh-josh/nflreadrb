# frozen_string_literal: true

RSpec.describe Nflreadrb do
  it "has a version number" do
    expect(Nflreadrb::VERSION).not_to be nil
  end

  it "successfully fetches player stats filtered by a specific year", :integration do
    puts "Streaming and filtering 2024 player stats..."
    stats = Nflreadrb.load_player_stats(2024)

    expect(stats).to be_an(Array)
    expect(stats.empty?).to be false

    # Extract all unique values from the 'season' column to prove the filter worked
    distinct_seasons = stats.map { |row| row["season"] }.uniq
    expect(distinct_seasons).to eq([2024])

    # Verify Patrick Mahomes is present in the filtered 2024 subset
    mahomes_records = stats.select { |row| row["player_name"] == "P.Mahomes" }
    expect(mahomes_records.any?).to be true

    puts "Success! Found #{mahomes_records.count} stats entries exclusively for the 2024 season."
  end
end