# frozen_string_literal: true

module Nflreadrb
  class Schedules < BaseLoader
    def initialize(year:, columns:)
      super(year:, columns:)
      @url = "#{Constants::BASE_URL}/schedules/games.parquet"
    end
    private_class_method :new
  end

  private_constant :Schedules
end