#
# Cookbook:: mongodb
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

apt_update 'update_sources' do
  action :update
end

apt_repository 'mongodb-org' do
  uri 'http://repo.mongodb.org/apt/ubuntu'
  distribution 'xenial/mongodb-org/3.2'
  components ['multiverse']
  keyserver 'hkp://keyserver.ubuntu.com:80'
  key 'EA312927'
  action :add
end

package 'mongodb-org' do
  options '--allow-unauthenticated'
  action :install
end

service 'mongod' do
  action [:enable, :start]
end


template '/etc/mongod.conf' do
  source 'mongod.conf.erb'
  variables(bind_ip: node['mongod']['bind_ip'], port: node['mongod']['port'])
  notifies :restart, 'service[mongod]'
end

template '/lib/systemd/system/mongod.service' do
  source 'mongod.service.erb'
end
