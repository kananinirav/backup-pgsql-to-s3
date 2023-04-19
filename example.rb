# frozen_string_literal: true

# Example
class Example
  require 'backup_pgsql_s3'

  def self.backup_to_s3
    BackupPgsqlS3.configure do |config|
      config.database_config = {
        host: 'host',
        dbname: 'db name',
        user: 'user',
        password: 'password'
      }
      config.backup_config = {
        backup_filename: '/tmp/my_database.backup',
        compression: true,
        delete_after_upload: true,
        s3_path: 'path/to/backups'
      }
    end

    # to backup file to s3
    BackupPgsqlS3.backup
  end
end
