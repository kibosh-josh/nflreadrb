# frozen_string_literal: true

module Nflreadrb
  class Injuries < BaseLoader
    def initialize(year:, columns:)
      super(year:, columns:)
      @url = "#{Constants::BASE_URL}/injuries/injuries_#{year}.parquet"
    end
    private_class_method :new
  end

  private_constant :Injuries
end
