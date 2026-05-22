# frozen_string_literal: true

module Nflreadrb
  class Schedules < BaseLoader
    def initialize(year:)
      @year = year
      @url = "#{Constants::BASE_URL}/schedules/games.parquet"
    end
    private_class_method :new

    def self.load(year:)
      new(year:).load_data
    end
  end

  private_constant :Schedules
end