#
# Cookbook:: mongo
# Attribute:: repository
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

repository = default['mongo']['repository']

repository['mirror'] = 'https://repo.mongodb.org'

case node['platform_family']
when 'rhel', 'fedora'
  if 'amazon' == node['platform']
    repository['url'] = 'https://repo.mongodb.org/yum' \
                        "/amazon/2013.03/mongodb-org/#{pkg_major}/x86_64/"
  else
    arch = node['kernel']['machine'] =~ /x86_64/ ? 'x86_64' : 'i686'
    repository['url'] = 'https://repo.mongodb.org/yum' \
                        "/redhat/$releasever/mongodb-org/#{pkg_major}/#{arch}"
  end
when 'debian'
  repository['url'] = "https://repo.mongodb.org/apt/#{node['platform']}"
  case node['platform']
  when 'ubuntu'
    repository['apt']['components'] = ['multiverse']
    repository['apt']['keyserver']  = 'hkp://keyserver.ubuntu.com:80'
  when 'debian'
    repository['apt']['components'] = ['main']
    repository['apt']['keyserver']  = 'keyserver.ubuntu.com'
  end
  repository['apt']['distribution'] = "#{node['lsb']['codename']}/mongodb-org" \
                                      "/#{pkg_major}"
end

repository['yum']['gpgcheck']  = false
repository['yum']['sslverify'] = false
repository['apt']['key'] = pkg_major >= 3.2 ? 'EA312927' : '7F0CEB10'
