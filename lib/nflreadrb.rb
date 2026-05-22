# frozen_string_literal: true

require 'open-uri'
require 'tempfile'
require 'polars'

require_relative 'nflreadrb/version'
require_relative 'nflreadrb/constants'
require_relative 'nflreadrb/player_stats'
require_relative 'nflreadrb/weekly_rosters'

module Nflreadrb
  class Error < StandardError; end

  class << self
    def load_player_stats(year:)
      PlayerStats.load(year:)
    end

    def load_rosters(year:)
      WeeklyRosters.load(year:)
    end
  end
end