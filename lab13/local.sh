java -version

echo "Starting Spring Application"


function graceful_shutdown(){
        echo "Graceful shutdown"
#	PID=$(ps -ef | grep "java -jar" | grep -v grep |cut -d " " -f 5)
	kill -9 $PID
        exit 0
}

FLAG=1
sleep 1
ARG=$1

trap graceful_shutdown  SIGINT SIGTERM


java -jar SpringBasicRefresherApp/target/SpringRefresher-0.0.1-SNAPSHOT.jar &

PID=$!

echo "$PID"
