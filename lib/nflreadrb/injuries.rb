# frozen_string_literal: true

module Nflreadrb
  class Injuries < BaseLoader
    def self.load(year:)
      new(year:).load_data
    end

    def initialize(year:)
      @year = year
      @url = "#{Constants::BASE_URL}/injuries/injuries_#{year}.parquet"
    end
    private_class_method :new
  end

  private_constant :Injuries
end