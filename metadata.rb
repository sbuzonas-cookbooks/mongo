name 'mongo'
maintainer 'Steve Buzonas'
maintainer_email 'steve@fancyguy.com'
license 'apachev2'
description 'Installs/Configures mongo'
long_description 'Installs/Configures mongo'
version '0.1.0'

# rubocop:disable Metrics/LineLength
issues_url 'https://github.com/sbuzonas-cookbooks/mongo/issues' if respond_to?(:issues_url)
source_url 'https://github.com/sbuzonas-cookbooks/mongo' if respond_to?(:source_url)
# rubocop:enable Metrics/LineLength

depends 'apt', '~> 6.0.1'

supports 'amazon'
supports 'centos'
supports 'debian'
supports 'fedora'
supports 'oracle'
supports 'redhat'
supports 'ubuntu'
