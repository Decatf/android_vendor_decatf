#!/system/bin/sh

#
# Contraints:
#  rcu preempt tasks must be higher priority than
#  [irq/284-mmc0] and dhd_dpc
#
#  Build the kernel with:
#   CONFIG_RCU_KTHREAD_PRIO=1
#
#
# Reasoning and motivations:
#  Order of realtime tasks in order of lowest to highest priority.
#
#    [PR]    POLICY       ARGS
#    22      SCHED_OTHER  [dhd_dpc]
#    22      SCHED_OTHER  [irq/288-mmc0]
#
#    -2      SCHED_RR     [irq/229-sec_hea]
#    -2      SCHED_RR     [irq/216-lm90]
#    -2      SCHED_RR     [irq/294-tps6586]
#
#    -2      SCHED_RR     [mmcqd/1]
#
#    -2      SCHED_FIFO   surfaceflinger
#
#                         ...
#    -2      SCHED_FIFO   rcu tasks
#                         ...
#
#    RT(-48) SCHED_FIFO   [avp_svc_thread]
#    RT(-48) SCHED_FIFO   [dc_worker_threa]
#    RT(-48) SCHED_FIFO   [host_syncpt]
#    RT(-48) SCHED_FIFO   [tegradc.0/a]
#
#    RT(-50) SCHED_FIFO   [irq/78-sec_touc]
#    RT(-50) SCHED_FIFO   [irq/289-mmc1]
#
#
#  Round Robin tasks are more preemptable (than SCHED_FIFO)
#  Storage(mmcqd/1) is set to SCHED_RR to lessen the impact of
#  waiting on slow hardware.
#  wifi(dhd_dpc and irq/288-mmc0) are set to SCHED_OTHER
#  (also round robin).
#
#  Tegra dc and host1x tasks are set to very high prio
#  because they are critical display blanking/vsync operations.
#  Delayed host1x tasks can lead to the syncpt stuck error.
#  avp_svc is run 30+ times per second during video decode.
#

NAME=$(echo $0 | awk -F "/" '{print $NF}')

/system/bin/log -t $NAME Running.

# Lessen the impact of not so critical tasks
PID_LM90=$(pgrep 'irq/216-lm90')
PID_SEC_JACK=$(pgrep 'irq/229-sec_hea')
PID_TPS6586=$(pgrep 'irq/294-tps6586')
[[ -n $PID_LM90 ]] && chrt -p $PID_LM90 -r 1
[[ -n $PID_SEC_JACK ]] && chrt -p $PID_SEC_JACK -r 1
[[ -n $PID_TPS6586 ]] && chrt -p $PID_TPS6586 -r 1

# PID_MMC0=$(pgrep 'irq/288-mmc0')
# PID_DHD=$(pgrep 'dhd_dpc')
# [[ -n $PID_MMC0 ]] && chrt -p $PID_MMC0 -o 0
# [[ -n $PID_DHD ]] && chrt -p $PID_DHD -o 0
# [[ -n $PID_MMC0 ]] && renice -n +2 -p $PID_MMC0
# [[ -n $PID_DHD ]] && renice -n +2 -p $PID_DHD

# Allow storage to be preempted(???)
# PID_MMCQD1=$(ps -A | grep -E '\[mmcqd\/1\]' | awk '{ print $2 }')
# [[ -n $PID_MMCQD1 ]] && chrt -p $PID_MMCQD1 -r 1

# irq threads are created with:
#   sched_priority = MAX_USER_RT_PRIO/2
#   (Where MAX_USER_RT_PRIO is 50)
# Set the display tasks lower than that.
PID_TEGRADC0=$(pgrep 'tegradc.0/a')
PID_HOST_SYNCPT=$(pgrep 'host_syncpt')
PID_AVP_SVC=$(pgrep 'avp_svc_thread')
PID_DC_WORKER=$(pgrep 'dc_worker')
[[ -n $PID_TEGRADC0 ]] && chrt -p $PID_TEGRADC0 -f 47
[[ -n $PID_HOST_SYNCPT ]] && chrt -p $PID_HOST_SYNCPT -f 47
[[ -n $PID_AVP_SVC ]] && chrt -p $PID_AVP_SVC -f 47
[[ -n $PID_DC_WORKER ]] && chrt -p $PID_DC_WORKER -f 47

/system/bin/log -t $NAME Done.
