require 'spec_helper'

# 以下のサイトを参考にしました;
# https://github.com/akahigeg/rbenv-install-rubies-cookbook/blob/master/spec/default/rbenv_spec.rb
describe file('/usr/local/rbenv') do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

# ruby versions
describe file('/usr/local/rbenv/versions/2.1.0') do
  it { should be_directory }
end

# global
describe command('ruby -v') do
  let(:path) { '/usr/local/rbenv/shims' }
  it { should return_stdout 'ruby 2.1.0p0 (2013-12-25 revision 44422) [x86_64-linux]' }
end

# gem
describe package('bundler') do
  let(:path) { '/usr/local/rbenv/shims' }
  it { should be_installed.by('gem') }
end

describe package('rails') do
  let(:path) { '/usr/local/rbenv/shims' }
  it { should be_installed.by('gem') }
end

describe package('therubyracer') do
  let(:path) { '/usr/local/rbenv/shims' }
  it { should be_installed.by('gem') }
end