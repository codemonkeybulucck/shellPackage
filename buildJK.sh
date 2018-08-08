#!/bin/bash
ps -fe|grep "jenkins" |grep -v grep
if [ $? -ne 0 ]
then
echo "******请先使用Jenkins -h来启动jenkins**********"
else
echo "********检测到Jenkins已经启动**********"
fi
LOCALHOST="http://localhost:8080/"
CLIJAR="/Users/lemon/jenkins-cli.jar"

java -jar ${CLIJAR} -s ${LOCALHOST} -ssh -user admin list-jobs

echo "*******请输入你要构建的任务*******"
read BuildName

java -jar ${CLIJAR} -s ${LOCALHOST} -ssh -user admin build ${BuildName}
if [ $? -ne 0 ]; then
echo "*******正在构建${BuildName}，构建完成后会自动打开本地文件夹*******"
else
echo "*******构建${BuildName}失败，请检查是否有对应的任务*******"
fi

