# InSpec test for recipe mongodb::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root') do
    it { should exist }
  end
end

# This is an example test, replace it with your own test.

describe package('mongodb-org') do
  it { should be_installed }
  its('version'){ should match /3\./ }
end

describe service('mongod') do
  it { should be_running }
  it { should be_enabled }
end

# Test mongodb config file is created with right permission.
describe file('/etc/mongod.conf') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe port('0.0.0.0', 27017) do
  it { should be_listening }
end
