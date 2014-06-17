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

# install python-software-properties
if node['platform'] =~ /ubuntu/
  package 'python-software-properties libcurl4-openssl-dev' do
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

bash 'delete file site-enabled/default' do
  user 'root'
  cwd '/etc/nginx/sites-enabled/'
  code <<-EOC
    rm -rf default
  EOC
end
