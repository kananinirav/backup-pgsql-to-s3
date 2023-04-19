# Backup a Postgresql db dump and upload to s3 in ruby on rails

To backup a PostgreSQL database and upload the dump to Amazon S3 in a Ruby on Rails application, you can follow the steps below:

1. Install the `aws-sdk-s3` gem by adding it to your Gemfile and running bundle install.
2. create .pgpass file in your home director
   - `vi ~/.pgpass`
   - Add your db credential to pgpass file `hostname:port:database:username:password`
   - pgpass file access permissions should be u=rw (0600) or less `chmod 600 ~/.pgpass`
   - [more information about pgpass](https://www.postgresql.org/docs/current/libpq-pgpass.html)
3. create `aws_config.rb` in `config/initializers` folder
4. create `aws_s3_credential.yml` in `config` folder and update your credentials
5. copy `backup_pgsql_s3` folder and `backup_pgsql_s3.rb` file in your lib folder.
6. add `require 'backup_pgsql_s3'` in file where you want to use
7. set configurations

    ```ruby
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
    ```

8. Now just add `BackupPgsqlS3.backup`

Example: [click](./example.rb)

If you want to backup everyday then setup Cron Job using Whenever gem [Cron Job Setup article](https://medium.com/@kanani-nirav/scheduling-tasks-using-the-whenever-gem-ruby-on-rails-5e61c82ad563)

If this guide has been helpful to you and your team please share it with others!
