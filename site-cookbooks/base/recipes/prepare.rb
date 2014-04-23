case node['platform']
  when /ubuntu/
    include_recipe 'apt'
  when /centos/
    include_recipe 'yum'
    include_recipe 'yum-epel'
end

bash 'set JST timezone' do
  user 'root'
  cwd '/etc'
  if node['platform'] =~ /ubuntu/
    code <<-EOC
      rm /etc/localtime
      ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
      service cron restart
    EOC
  elsif node['platform'] =~ /centos/
    code <<-EOC
      rm /etc/localtime
      ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
      service crond restart
    EOC
  end
end