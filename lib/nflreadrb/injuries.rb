# frozen_string_literal: true

module Nflreadrb
  # Loads injury data for a given year. Columns filtering can be added to return only a subset of data
  class Injuries < BaseLoader
    def initialize(year:, columns:)
      super
      @url = "#{Constants::BASE_URL}/injuries/injuries_#{year}.parquet"
    end
    private_class_method :new
  end

  private_constant :Injuries
end
