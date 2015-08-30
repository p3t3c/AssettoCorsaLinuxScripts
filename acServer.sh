#/bin/bash
ASSETTO_DIR="/home/assettocorsa/steam/steamapps/common/Assetto Corsa Dedicated Server/"
PIDFILE=/home/assettocorsa/acServer.pid
LOGFILE=/home/assettocorsa/acServer.log
DAEMON="$ASSETTO_DIR/acServer"


case $1 in
	start)
		# Startas bash and pass an bash exec 
		# this allows the log output to be captured
		# See: http://stackoverflow.com/questions/8251933/how-can-i-log-the-stdout-of-a-process-started-by-start-stop-daemon
		start-stop-daemon --start \
		                  --background \
		                  --user assettocorsa \
		                  --name acServer  \
		                  --make-pidfile \
		                  --pidfile $PIDFILE \
		                  --chdir "$ASSETTO_DIR" \
		                  --chuid assettocorsa \
		                  --startas /bin/bash \
		                  -- -c "exec \"$ASSETTO_DIR/acServer\" &> $LOGFILE"

		if [ $? -eq 0 ] ; then
		   echo "Server Started"
		else
		   echo "Server Start Failed!"
		fi
		;;
	stop)
		start-stop-daemon --stop \
		                  --user assettocorsa \
		                  --name acServer \
		                  --pidfile $PIDFILE \
		                  --retry 5

		if [ $? -eq 0 ] ; then
		   echo "Server Stopped"
		else
		   echo "Can't stop server"
		fi
		rm $PIDFILE
		mv $LOGFILE $LOGFILE.last
		;;
	restart)
                $0 stop && sleep 2 && $0 start
                ;;
	status)
		status="Not Running"
		read pidtest < $PIDFILE &>/dev/null
		if [ -n pidtest ] ; then
			/bin/ps "${pidtest:-}" >/dev/null 2>&1
			if [ $? -eq 0 ] ; then
				status="Running"
			fi
		fi
		echo "Server is $status"
		;;
	tail)
		tail -f $LOGFILE
		;;
	*)
		echo "Usage: $0 {start|stop|restart|status|tail}"
		;;
esac
