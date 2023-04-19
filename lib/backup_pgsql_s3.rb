# frozen_string_literal: true

require 'backup_pgsql_s3/configuration'
require 'backup_pgsql_s3/database'
require 'backup_pgsql_s3/s3'

# BackupPgsqlS3
module BackupPgsqlS3
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    def backup
      backup_filename = Database.backup(configuration)
      S3.upload(configuration, backup_filename)
      File.delete(backup_filename) if configuration.backup_config[:delete_after_upload]

      backup_filename
    end
  end
end
