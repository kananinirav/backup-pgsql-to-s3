# frozen_string_literal: true

# lib/backup_pgsql_s3/database.rb
module BackupPgsqlS3
  # Database
  class Database
    def self.backup(configuration)
      generate_backup_file(configuration)

      return configuration.backup_config[:backup_filename] unless configuration.backup_config[:compression]

      # Compress the backup file if necessary
      compressed_filename = "#{configuration.backup_config[:backup_filename]}.gz"
      Zlib::GzipWriter.open(compressed_filename) do |gzip|
        gzip.write(File.read(configuration.backup_config[:backup_filename]))
      end
      File.delete(configuration.backup_config[:backup_filename])
      compressed_filename
    end

    def self.generate_backup_file(configuration)
      # Create a backup of the database
      backup_command = "PGPASSFILE=#{ENV['HOME']}/.pgpass pg_dump -Fc #{configuration.database_config[:dbname]}"
      backup_command += " -h #{configuration.database_config[:host]}" if configuration.database_config[:host]
      backup_command += " -p #{configuration.database_config[:port]}" if configuration.database_config[:port]
      backup_command += " -U #{configuration.database_config[:user]}" if configuration.database_config[:user]
      backup_command += " > #{configuration.backup_config[:backup_filename]}"

      system(backup_command)
    end
  end
end
