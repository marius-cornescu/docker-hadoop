#!/bin/bash

: ${HADOOP_PREFIX:=/usr/local/hadoop}

$HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

rm /tmp/*.pid

# installing libraries if any - (resource urls added comma separated to the ACP system variable)
cd $HADOOP_PREFIX/share/hadoop/common ; for cp in ${ACP//,/ }; do  echo == $cp; curl -LO $cp ; done; cd -

# altering the core-site configuration
sed s/HOSTNAME/$HOSTNAME/ /usr/local/hadoop/etc/hadoop/core-site.xml.template > /usr/local/hadoop/etc/hadoop/core-site.xml

# set the USER env variable
export USER=`whoami`

echo -e "\e[1;31m > Start SSHD \e[0m"
service sshd start
#
echo -e "\e[1;31m > Start HADOOP:DFS \e[0m"
$HADOOP_PREFIX/sbin/start-dfs.sh
#
echo -e "\e[1;31m > Start HADOOP:Yarn \e[0m"
$HADOOP_PREFIX/sbin/start-yarn.sh
<<<<<<< HEAD
#$HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh start historyserver
=======
#
echo -e "\e[1;31m > Start HADOOP:JobHistoryServer \e[0m"
$HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh start historyserver
>>>>>>> 65fd91c675e226dd3aa85b5bd54d732b3db58e16

# install Tez
#export PATH=$HADOOP_PREFIX/sbin:$HADOOP_PREFIX/bin:$PATH
#hdfs dfsadmin -safemode wait
#hadoop fs -mkdir -p /apps/tez
#hadoop fs -copyFromLocal /root/tez/apache-tez-0.8.5-bin/share/tez.tar.gz /apps/apache-tez-0.8.5-bin.tar.gz
#export TEZ_CONF_DIR=/usr/local/hadoop/etc/hadoop/
#export TEZ_JARS=/root/tez/apache-tez-0.8.5-bin
#export HADOOP_CLASSPATH=${TEZ_CONF_DIR}:${TEZ_JARS}/*:${TEZ_JARS}/lib/*

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
