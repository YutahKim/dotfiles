import os
import time
import daemon

with daemon.DaemonContext():
    while True:
        #dont forget to install betterlockscreen
        os.system("feh --bg-fill --randomize $HOME/Pictures/bg/*")
        os.system("betterlockscreen -u $HOME/Pictures/bg")
        time.sleep(180)
