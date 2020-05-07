#!/bin/bash
#The purpose of this script is generate a Performance Workload
#in order to stress the Linux and certify that the z/VM 7.1 will hold high
#utilization charges.

#THIS SAMPLE WAS CODED TO LINUX ON Z

rm /tmp/report_$(hostname)
#CALCULATING THE CURRENT SERVER UTILIZATION:
echo "Pulse Loader v0.1
ID and LPAR: $(vmcp q userid)
Date: $(date)
Program: 3 days
" > /tmp/report_$(hostname)

#PROCESSOR
rm teste1
ps aux | awk '{ print $3 }' | grep -v 0.0 | grep -v CPU > teste1
totalcpu=$(bc <<< "$(tr '\n' '+' < teste1 | sed 's/+$//')")
cpu=$(cat /proc/cpuinfo | grep processors | awk '{print $4}')

if [ -z "$totalcpu" ] #CHECKING FOR NULL VALUE
then
      echo "Current CPU utilization is 0 %" >> /tmp/report_$(hostname)
else
      echo "Current CPU utilization is $totalcpu%" >> /tmp/report_$(hostname)
fi
#MEMORY:
total=$(free -m | grep -i mem | awk '{print $2}' | grep -v shared)
free=$(free -m | grep buffers | awk '{print $4}' | grep -v shared)
part1=$(expr $free \* 100)
part2=$(expr $part1 / $total)
echo "Current memory utilization is $part2%" >> /tmp/report_$(hostname)
echo "" >> /tmp/report_$(hostname)

 


echo "THE PERFORMANCE TEST HAS BEEN INITIATED..." >> /tmp/report_$(hostname)
#DECLARING VARIABLES
x=1
perc=50
cp=2

#STARTING THE LOOP
while [ $x -lt 4 ]
do
echo "Initiating STAGE $x - $perc% of charge
Estimated duration: 24 Hours" >> /tmp/report_$(hostname)

#NOTIFICATING THE TEAM:
echo "PULSE LOADER - STARTED STAGE $x
SERVER DETAILS:
$(hostname -f)
$(vmcp q userid)
 
THIS STAGE WILL LOAD THE SERVER AT $perc% OF ITS UTILIZATION.
ESTIMATED DURATION: 24 hours

NOTE: STAGE $x OF 3.
IF YOU DO NOT RECEIVE THE NEXT STAGE NOTIFICATION IN 24 HOURS
POSSIBLY Z/VM 7.1 CRACKED AND LNXVMA IS DOWN!

Gaiotto - gaiotto@gmail.com
" | mail -s "Pulse Loader - Started STAGE $x" gaiotto@gmail.com

/tmp/stress-ng-0.09.56/stress-ng --cpu $cp --io 1 --vm 1 --vm-bytes $perc% --timeout 86300s --metrics-brief
echo "" >> /tmp/report_$(hostname)

#sleep 1d - THE sleep COMMAND IS ACTUALLY NOT NEEDED ONCE
#THE PROCESS WILL BE STUCKED IN THE stress COMMAND ABOVE.

x=$(( $x + 1 ))
perc=$(( $perc + 25 ))
cp=$(( $cp + 2 ))
done
echo "The process has been completed
$(date)" >> /tmp/report_$(hostname)

echo "PULSE LOADER - PROCESS FINISHED
SERVER DETAILS:
$(hostname -f)
$(vmcp q userid)

THE LPAR AND THE LINUX SURVIVED.

Gaiotto - gaiotto@gmail.com
" | mail -s "Pulse Loader - Process Finished" -a /tmp/report_$(hostname) gaiotto@gmail.com

#end of the code
