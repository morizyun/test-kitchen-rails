# test-kitchen with Ubuntu 12.04/MySQL/Nginx/Ruby 2.1.0/severspec

_Description: test-kitchen(Vagrant) with Ubuntu 12.04/MySQL/Nginx/Ruby 2.1.0/severspec

## Setup Ubuntu

1. Download and install Vagrant http://www.vagrantup.com/

2. Download and install VirtualBox https://www.virtualbox.org/

3. `gem install test-kitchen`

4. `git clone https://github.com/morizyun/test-kitchen-rails-nginx test-kitchen-rails`

5. `cd test-kitchen-rails`

6. `bundle install --binstubs=bin`

7. `bundle exec berks vendor cookbooks`

8. `kitchen setup rails-va-ubuntu-1204`

9. `kitchen verify rails-va-ubuntu-1204`

10. Browsing `http://192.168.33.33`

## Basic information

1. Sync Folder(Sever - Local) : `.kitchen/kitchen-vagrant/default-ubuntu-1204/vagrant`

2. MySQL ROOT PASS : nothing

## More Detail

Please see http://morizyun.github.io/blog/test-kitchen-vagrant-rails-rbenv-chef-serverspec/