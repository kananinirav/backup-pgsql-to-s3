# frozen_string_literal: true

S3_CONFIG = YAML.load_file("#{::Rails.root}/config/aws_s3_credential.yml")

require 'aws-sdk-s3'

Aws.config.update({ region: S3_CONFIG[Rails.env]['region'],
                    credentials: Aws::Credentials.new(S3_CONFIG[Rails.env]['access_key_id'],
                                                      S3_CONFIG[Rails.env]['secret_access_key']) })

BUCKET = Aws::S3::Resource.new.bucket(S3_CONFIG[Rails.env]['bucket'])
