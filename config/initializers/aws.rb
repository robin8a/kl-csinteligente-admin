require 'aws-sdk'
require 'json'
creds = JSON.load(File.read('secrets.json'))
Aws.config[:credentials] = Aws::Credentials.new(creds['AccessKeyId'], creds['SecretAccessKey'])
region = 'us-east-1'
s3 = Aws::S3::Resource.new(region: region)

# reference an existing bucket by name
S3_BUCKET = s3.bucket('csinteligente.data.com')
