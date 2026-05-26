# frozen_string_literal: true

require 'tmpdir'
require 'fileutils'
require 'open-uri'

module Nflreadrb
  module LocalCache
    CACHE_EXPIRY = 86400 # 24 hours

    class << self
      def path_for(url)
        ensure_cache_directory_exists!

        target_path = File.join(cache_directory, File.basename(url))
        refresh_cache!(url, target_path) if cache_stale?(target_path)

        target_path
      end

      private

      def cache_directory
        File.join(Dir.tmpdir, 'nflreadrb_cache')
      end

      def ensure_cache_directory_exists!
        FileUtils.mkdir_p(cache_directory) unless Dir.exist?(cache_directory)
      end

      def cache_stale?(path)
        !File.exist?(path) || (Time.now - File.mtime(path) > CACHE_EXPIRY)
      end

      def refresh_cache!(url, destination)
        URI.parse(url).open do |remote_file|
          File.open(destination, 'wb') { |local_file| local_file.write(remote_file.read) }
        end
      rescue OpenURI::HTTPError => e
        raise NotFoundError, "Data file does not exist at url: #{url}: #{e.message}" if e.message.include?('404')

        raise Error, "Failed to fetch data from url: #{url}: #{e.message}"
      end
    end
  end

  private_constant :LocalCache
end
