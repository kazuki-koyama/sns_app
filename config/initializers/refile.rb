require 'refile/s3'
aws = {
  access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  region: ENV['AWS_REGION'],
  bucket: ENV['AWS_S3_BUCKET_NAME']
}
Refile.cache = Refile::S3.new(prefix: 'cache', **aws)
# 画像の種類(カラム)により、prefixを
Refile.backends['before_image'] = Refile::S3.new(prefix: 'before_image', **aws)
Refile.backends['after_image'] = Refile::S3.new(prefix: 'after_image', **aws)
Refile.backends['profile_image'] = Refile::S3.new(prefix: 'profile_image', **aws)