# Nflreadrb

A high-performance, cached Parquet data loader for `nflverse` datasets in Ruby.

## `nflreadrb` leverages the **Polars** engine and a stateless **local filesystem caching** layer to stream, filter, and dynamically slice production NFL data files with sub-5ms latency, minimizing both network overhead and RAM footprint.

## Installation

To install the gem locally for development or to test with your web API application, add this line to your application's `Gemfile`: `gem 'nflreadrb', path: '/path/to/your/local/nflreadrb'`
And then execute:
`$ bundle install`

---

## Architecture & Performance Benefits

- **Stateless Local Cache:** Automated 24-hour expiration filesystem caching via the OS temporary directory (`Dir.tmpdir`). The external network is hit exactly _once per file per day_, completely eliminating remote API latency on subsequent requests.
- **Projection Pushdown:** Column filtering happens directly at the I/O layer via Polars. If you only request two columns out of a 100+ column dataset, only those two columns are parsed into memory.
- **Encapsulated Design:** Internal data-loading strategies, constructors, and base classes are securely wrapped and hidden to ensure a strict, predictable public API boundary.

---

## Usage

Every data-loading gateway method requires a `year:` argument and accepts an optional `columns:` array (supporting both Strings and Symbols).

### 1. Load Player Stats

#### Fetch all statistics columns for 2024 (Returns Array of Hashes)

`stats = Nflreadrb.load_player_stats(year: 2024)`

#### Optimize for web API JSON payloads by requesting specific columns

`optimized_stats = Nflreadrb.load_player_stats(year: 2024, columns: [:player_id, :player_name, :passing_yards, :touchdowns])`

### 2. Load Weekly Rosters

`rosters = Nflreadrb.load_rosters(year: 2024, columns: [:gsis_id, :full_name, :position])`

### 3. Load Injuries

`injuries = Nflreadrb.load_injuries(year: 2024, columns: [:full_name, :report_status])`

### 4. Load Schedules

`schedules = Nflreadrb.load_schedules(year: 2024, columns: [:game_id, :home_team, :away_team])`

### 5. Load Snap Counts

```
columns = [:game_id, :pfr_player_id, :offense_snaps]
snap_counts = Nflreadrb.load_snap_counts(year: 2024, columns:)
```

---

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kibosh-josh/nflreadrb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/kibosh-josh/nflreadrb/blob/main/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the Nflreadrb project's codebases, issue trackers, chat rooms, and mailing lists is expected to follow the [code of conduct](https://github.com/kibosh-josh/nflreadrb/blob/main/CODE_OF_CONDUCT.md).
