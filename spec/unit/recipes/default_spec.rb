#
# Cookbook:: mongodb
# Spec:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mongodb::default' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '16.04'

    it 'should update source list' do
      expect(chef_run).to update_apt_update 'update_sources'
    end

    it 'should add mongod to source list' do
      expect(chef_run).to add_apt_repository('mongodb-org')
    end

    it 'should create mongod.conf template in /etc/mongod.conf' do
           expect(chef_run).to create_template("/etc/mongod.conf").with_variables(bind_ip:'0.0.0.0', port:27017)
     end

     it 'should create mongod.service template in /lib/systemd/system/mongod.service' do
       expect(chef_run).to create_template "/lib/systemd/system/mongod.service"
     end

     it 'converges successfully' do
       expect { chef_run }.to_not raise_error
     end



   end
end
