# frozen_string_literal: true

# lib/backup_pgsql_s3/s3.rb
require 'aws-sdk-s3'

module BackupPgsqlS3
  # S3
  class S3
    def self.upload(configuration, backup_filename)
      # Set the S3 path for the backup file
      s3_config_path = configuration.backup_config[:s3_path] || '/backups'
      s3 = BUCKET
      s3_path = "#{s3_config_path}/#{Time.now.strftime('%Y%m%d%H%M')}/#{File.basename(backup_filename)}"
      s3.object(s3_path).upload_file(backup_filename, acl: 'public-read')
    end
  end
end
