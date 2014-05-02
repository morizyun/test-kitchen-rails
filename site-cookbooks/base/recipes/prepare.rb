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

bash 'add swap memory' do
  user 'root'
  cwd '/var'
  code <<-EOC
    mkdir /var/swap
    dd if=/dev/zero of=/var/swap/swap0 bs=1M count=2048
    chmod 600 /var/swap/swap
    mkswap /var/swap/swap0
    swapon /var/swap/swap0
    echo '/var/swap/swap0 swap swap defaults 0 0' >> /etc/fstab
  EOC
end