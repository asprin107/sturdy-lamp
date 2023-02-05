#!/bin/sh

yum update -y
#yum install -y wget

echo "Create jmeter home directory"
mkdir -p /JmeterHome

echo "Download jmeter"
wget https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-5.5.zip -P /JmeterHome

echo "Unzip jmeter"
unzip /JmeterHome/apache-jmeter-5.5.zip -d /JmeterHome

echo "Download jmeter plugin 'plugin-manager'"
wget https://jmeter-plugins.org/get -P /JmeterHome/apache-jmeter-5.5/lib/ext

echo "Download jmeter plugin 'jpgc-graphs-basic'"
wget https://jmeter-plugins.org/files/packages/jpgc-graphs-basic-2.0.zip -P /JmeterHome
unzip /JmeterHome/jpgc-graphs-basic-2.0.zip -d /JmeterHome
cp -r /JmeterHome/lib/* /JmeterHome/apache-jmeter-5.5/lib/

echo "Download jdk8"
wget https://cdn.azul.com/zulu/bin/zulu8.68.0.21-ca-jdk8.0.362-linux_x64.tar.gz -P /JmeterHome

echo "Unzip jdk8"
tar -zxf /JmeterHome/zulu8.68.0.21-ca-jdk8.0.362-linux_x64.tar.gz -C /JmeterHome

echo "Add jdk8 in Environment 'Path'"
echo '
# Add Java home environment
export JAVA_HOME=/JmeterHome/zulu8.68.0.21-ca-jdk8.0.362-linux_x64
export PATH=$JAVA_HOME/bin:$PATH
' >> /etc/profile

echo "Add Script on startup."
cat <<EOF >> /etc/rc.d/init.d/autostart_jmeter_rmi.sh
JMETER_HOME="/JmeterHome/apache-jmeter-5.5/bin/"
$JMETER_HOME/jmeter-server
EOF
chmod +x /etc/rc.d/init.d/autostart_jmeter_rmi.sh

reboot