require 'spec_helper'

describe service('nginx') do
  it { should be_running }
end

describe file('/usr/share/nginx/www') do
  it { should be_directory }
end

describe command('curl http://localhost:3000') do
  it { should return_stdout /Ruby\son\sRails/ }
end

describe command('curl http://localhost') do
  it { should return_stdout /Ruby\son\sRails/ }
end