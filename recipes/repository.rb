#
# Cookbook:: mongo
# Recipe:: repository
#
# Copyright:: 2017, Steve Buzonas
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

pkg_major = node['mongo']['version'].to_f

case node['platform_family']
when 'rhel', 'fedora'
  yum_repository "mongodb-#{pkg_major}" do
    description 'MongoDB Repository'
    baseurl     node['mongo']['repository']['url']
    gpgcheck    node['mongo']['repository']['yum']['gpgcheck']
    sslverify   node['mongo']['repository']['yum']['sslverify']
    enabled     true
    action      :create
  end
when 'debian'
  apt_repository "mongodb-#{pkg_major}" do
    uri          node['mongo']['repository']['url']
    distribution node['mongo']['repository']['apt']['distribution']
    components   node['mongo']['repository']['apt']['components']
    keyserver    node['mongo']['repository']['apt']['keyserver']
    key          node['mongo']['repository']['apt']['key']
    action :add
  end
  include_recipe 'apt'
else
  Chef::Log.warn("Installing the mongodb repository is not yet supported for the #{node['platform_family']} platform family.")
end
