# iptables無効
service 'iptables' do
  action [:stop, :disable]
end

# curlの導入
%w{curl}.each do |p|
  package p do
    action :install
  end
end

template 'nginx.conf' do
  path '/etc/nginx/nginx.conf'
  source 'nginx.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :reload , 'service[nginx]'
end

directory '/etc/nginx/sites-enabled' do
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

template '/etc/nginx/sites-enabled/default.conf' do
  source 'sites-enabled.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :reload, 'service[nginx]'
end

directory '/usr/share/nginx/rails' do
  action :create
end

# gems = %w(bundler rails sqlite3 therubyracer mysql2)
# gems.each do |gem|
#   gem_package gem do
#     action :install
#     options '--no-ri --no-rdoc'
#   end
# end

# bash 'remove mysql root password' do
#   code <<-EOC
#    mysql -u root -p#{node['mysql']['server_root_password']}
#    set password for root@localhost=password('');
#    exit
#   EOC
# end

bash 'create rails project' do
  cwd '/usr/share/nginx/rails'
  code <<-EOC
   su vagrant
   rm -rf #{node['nginx']['application_name']}
   rails new #{node['nginx']['application_name']} --database=mysql
   cd #{node['nginx']['application_name']}
   echo "gem 'therubyracer'" >> Gemfile
   bundle install
   sed -i "s/password:/password: #{node['mysql']['server_root_password']}/g" config/database.yml
   bundle exec rake db:create
   rails s --daemon
  EOC
end