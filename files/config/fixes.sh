sudo su

echo "export JAVA_HOME=\"/usr/lib/jvm/default-java\"\nexport CLASSPATH=`hadoop classpath`" > /etc/profile.d/envvars.sh

echo "LC_ALL=\"en_US.UTF-8\"" >> /etc/default/locale

mkdir /usr/lib/zookeeper
mkdir /usr/lib/zookeeper/lib
ln -s /usr/share/java/zookeeper.jar /usr/lib/zookeeper/zookeeper.jar
ln -s /usr/share/java/slf4j-log4j12.jar /usr/lib/zookeeper/lib/slf4j-log4j12.jar
ln -s /usr/share/java/slf4j-api-1.7.5.jar /usr/lib/hive/lib/slf4j-api-1.7.5.jar

cp /vagrant/files/config/hive-site.xml /etc/hive/conf/hive-site.xml

