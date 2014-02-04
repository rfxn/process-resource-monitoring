tmpemail=$inspath/tmp/.email.$$
cat > $tmpemail <<EOF
The following is a summary event for process resource monitor on $(hostname):

EVENT: $MAX_NAME use:${rval} / max:${MAX_VAL}
EOF
if [ "$ALERT_ONLY" == "1" ]; then
cat >> $tmpemail <<EOF
ACTION: not killed - alert only mode
EOF
else
 if [ "$KILL_PARENT" == "1" ]; then
cat >> $tmpemail <<EOF
ACTION: killed parent/child procs with 'kill -$KILL_SIG $pidlist'

EOF
 else
cat >> $tmpemail <<EOF
ACTION: killed proc $pidlist with 'kill -$KILL_SIG $pidlist'
EOF
 fi
fi
if [ "$KILL_RESTART_CMD" ]; then
cat >> $tmpemail <<EOF
RESTART: executed '$KILL_RESTART_CMD'
EOF
fi
cat >> $tmpemail <<EOF

PPID: $ppid
PID: $pid
USER: $user
CPU: ${cpu}% (max $MAX_CPU)
MEM: ${mem}% (max $MAX_MEM)
ETIME: $etime_full (max $MAX_ETIME)
PROCS: $proc (max $MAX_PROC)
CMD: $cmd_full

========================================================
PRM (Process Resource Monitor) v$ver < prm@rfxn.com >

EOF
