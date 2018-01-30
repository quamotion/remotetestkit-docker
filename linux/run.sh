echo "Starting adb"
/usr/sbin/adb -a -P 5037 server nodaemon &
adb_pid=$!

echo "adb is running in the background with pid $adb_pid"

echo "Starting the Thrift API Server"
cd /app
java -version
java nttr.rtk.MainForThriftServer

echo "Stopping adb"
/usr/sbin/adb kill-server

echo "Exiting"
