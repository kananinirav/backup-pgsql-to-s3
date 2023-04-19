# frozen_string_literal: true

# lib/backup_pgsql_s3/configuration.rb

module BackupPgsqlS3
  # Configuration
  class Configuration
    attr_accessor :database_config, :s3_config, :backup_config

    def initialize
      @database_config = {}
      @s3_config = {}
      @backup_config = {}
    end
  end
end
