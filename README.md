Rodrigo Gaiotto - gaiotto@gmail.com


Pulse Loader is a script developed to generate utilization charges Linux and Unix systems. It works based in the STRESS-NG, so it depends of the stress-ng package to run.
it will run in 3 stages applying charges 25% heavier each 24 run.

STRESS-NG SOURCE CODE:

https://kernel.ubuntu.com/~cking/tarballs/stress-ng/

Basic compilation:
1- tar xvf stress-ng-0.09.56.tar.xz
2- cd stress-ng-0.09.56/
3- make

Command syntax:
stress-ng --parameters value.

Example:
./stress-ng --cpu 5 --io 1 --vm 1 --vm-bytes 100% --timeout 120s --metrics-brief

Where:

-- cpu 5 will make use of 5 processors.
-- io 1 will generate one batch of I/O instructions
-- vm 1 --vmbytes 100% will generate one virtual instance that will pick up 100% of the memory available.
-- timeout 120s means that it will run for 120 seconds
-- metrics-brief will produce a report after the program execution.

Complete references:
https://manpages.ubuntu.com/manpages/artful/man1/stress-ng.1.html#bugs
https://www.cyberciti.biz/faq/stress-test-linux-unix-server-with-stress-ng/
