# frozen_string_literal: true

require 'open-uri'
require 'polars'

require_relative 'nflreadrb/version'
require_relative 'nflreadrb/constants'
require_relative 'nflreadrb/base_loader'
require_relative 'nflreadrb/player_stats'
require_relative 'nflreadrb/weekly_rosters'
require_relative 'nflreadrb/injuries'
require_relative 'nflreadrb/schedules'
require_relative 'nflreadrb/snap_counts'

module Nflreadrb
  class Error < StandardError; end

  class << self
    def load_player_stats(year:, columns: nil)
      PlayerStats.load(year:, columns:)
    end

    def load_rosters(year:, columns: nil)
      WeeklyRosters.load(year:, columns:)
    end

    def load_injuries(year:, columns: nil)
      Injuries.load(year:, columns:)
    end

    def load_schedules(year:, columns: nil)
      Schedules.load(year:, columns:)
    end

    def load_snap_counts(year:, columns: nil)
      SnapCounts.load(year:, columns:)
    end
  end
end