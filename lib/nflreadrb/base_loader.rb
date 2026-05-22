# frozen_string_literal: true

require_relative 'constants'
require_relative 'parquet_loader'

module Nflreadrb
  class BaseLoader
    def load_data
      ParquetLoader.fetch_and_filter(url:, year:)
    end

    private

    attr_reader :year, :url
  end

  private_constant :BaseLoader
end