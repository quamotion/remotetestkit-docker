echo "Starting adb"
/usr/sbin/adb -a -P 5037 server

echo "Starting the Thrift API Server"
cd /app
java -version
java nttr.rtk.MainForThriftServer

echo "Exiting"
