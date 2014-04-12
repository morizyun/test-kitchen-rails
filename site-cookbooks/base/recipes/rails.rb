directory '/usr/share/nginx/rails' do
  action :create
end

bash 'create rails project' do
  user 'root'
  cwd '/usr/share/nginx/rails'
  code <<-EOC
   su www-data
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