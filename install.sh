#!/bin/sh
INSPATH="/usr/local/prm"
BINPATH="/usr/local/sbin/prm"

if [ -d "files" ] && [ ! -d "$INSPATH" ]; then
        mkdir -p $INSPATH
        mkdir -p $INSPATH/logs
	chmod 750 $INSPATH
        cp -R files/* $INSPATH
        chmod 640 $INSPATH/* $INSPATH/rules/* >> /dev/null 2>&1
        chmod 750 $INSPATH/prm
	chmod 750 $INSPATH/rules $INSPATH/tmp
        ln -fs $INSPATH/prm $BINPATH
	ln -fs $INSPATH/logs/prm.log $INSPATH/log_prm
	if [ -d "/etc/cron.d" ]; then
		cron=1
		cp -f cron.prm /etc/cron.d/prm
		chmod 644 /etc/cron.d/prm
	fi
elif [ -d "files" ] && [ -d "$INSPATH" ]; then
	mv $INSPATH $INSPATH.bk$$
	rm -f $INSPATH.last
	ln -fs $INSPATH.bk$$ $INSPATH.last
        mkdir -p $INSPATH
        mkdir -p $INSPATH/logs
        chmod 750 $INSPATH
        cp -R files/* $INSPATH
        chmod 640 $INSPATH/* $INSPATH/rules/* >> /dev/null 2>&1
        chmod 750 $INSPATH/prm
        chmod 750 $INSPATH/rules $INSPATH/tmp
        ln -fs $INSPATH/prm $BINPATH
	ln -fs $INSPATH/logs/prm.log $INSPATH/log_prm
	cp -f $INSPATH.bk$$/rules/* $INSPATH/rules/ >> /dev/null 2>&1
	cp $INSPATH.bk$$/logs/* $INSPATH/logs/ >> /dev/null 2>&1
        if [ -d "/etc/cron.d" ]; then
                cron=1
                cp -f cron.prm /etc/cron.d/prm
                chmod 644 /etc/cron.d/prm
        fi
fi

echo ".: PRM installed"
echo "Install path:    $INSPATH"
echo "Config path:     $INSPATH/conf.prm"
echo "Executable path: $BINPATH"
if [ "$cron" == "1" ]; then
echo "CronJob path:    /etc/cron.d/prm"
fi
