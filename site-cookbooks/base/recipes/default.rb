# iptables無効
service 'iptables' do
  action [:stop, :disable]
end

# curlの導入
%w{curl python-software-properties}.each do |p|
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

