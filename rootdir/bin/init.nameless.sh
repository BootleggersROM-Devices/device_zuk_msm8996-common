#!/system/bin/sh
MemTotalStr=`cat /proc/meminfo | grep MemTotal`
MemTotal=${MemTotalStr:16:8}

if [ $MemTotal -lt 5242880 ]; then
    echo never > /sys/kernel/mm/transparent_hugepage/enabled
    echo never > /sys/kernel/mm/transparent_hugepage/defrag
else
    echo madvise > /sys/kernel/mm/transparent_hugepage/enabled
    echo madvise > /sys/kernel/mm/transparent_hugepage/defrag
fi

if [ $MemTotal -lt 3000000 ]; then
   echo 1 > /sys/kernel/mm/ksm/run
else
   echo 0 > /sys/kernel/mm/ksm/run
fi
