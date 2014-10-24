
$packages = [ "default-jdk", "hadoop", "pig", "hive", "hive-hcatalog", "hbase" ]

apt::source { 'cloudera':
  location   => 'http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh',
  release    => 'trusty-cdh5',
  repos      => 'contrib',
  key        => '02A818DD',
  key_source => 'http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/archive.key'
}-> 
package { $packages:
    ensure => latest
}
