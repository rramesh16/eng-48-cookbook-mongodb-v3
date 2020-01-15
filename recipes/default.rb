#
# Cookbook:: mongodb
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

#imports
execute 'mongodb keyserver' do
  command 'wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -'
  action :run
end

execute 'mongodb key' do
  command 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list'
  action :run
end

include_recipe 'apt'
apt_update

execute 'mongodb' do
  command 'sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20'
  action :run
end

execute 'restart mongodb' do
  command 'sudo systemctl restart mongod'
  action :run
end

execute 'enable mongodb' do
  command 'sudo systemctl enable mongod'
  action :run
end
