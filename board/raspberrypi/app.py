import os
import time
from datetime import datetime
from ADCPi import ADCPi
adc = ADCPi(0x68, 0x69, 18)

time.sleep(5)

flipper = False

starttime = datetime.now()
while(starttime.year == 1970):
    print "System has failed to get network time"
    print "will keep trying until year != 1970"
    time.sleep(5)
    starttime = datetime.now()

filename = "wind" + starttime.strftime("%d%m%y_%H%M") +".csv"
print "filename is " + filename

print "started ADCPi object"
f = open("/mnt/"+filename,"w")
f.write("date,time,windspeed\n")
f.close()

while True:
    time.sleep(0.2)
    voltage = adc.read_voltage(1)
    wind = ((voltage-0.4)/1.6)*32.4

    now = datetime.now()

    outstr = now.strftime("%d/%m/%y,%H:%M:%S.%f")[:-3] + "," +str(wind) +"\n"
    flipper = not flipper
    if(flipper):
        os.system('echo 1 > /sys/class/leds/led0/brightness')
    else:
        os.system('echo 0 > /sys/class/leds/led0/brightness')
    
    f = open("/mnt/"+filename,"a")
    f.write(outstr)
    f.close()
