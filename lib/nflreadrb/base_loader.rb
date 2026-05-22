# frozen_string_literal: true

require_relative 'constants'
require_relative 'parquet_loader'

module Nflreadrb
  class BaseLoader
    def initialize(year:, columns:)
      @year = year
      @columns = columns
    end
    private_class_method :new

    def self.load(year:, columns: nil)
      new(year:, columns:).load_data
    end

    def load_data
      ParquetLoader.fetch_and_filter(url:, year:, columns:)
    end

    private

    attr_reader :year, :url, :columns
  end

  private_constant :BaseLoader
end