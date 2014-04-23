require 'spec_helper'

# MySQL のインストール確認
describe package('mysql-server') do
  it { should be_installed }
end

# MySQL サービスの稼働と自動起動の確認
describe service('mysql') do
  it { should be_enabled }
  it { should be_running }
end
