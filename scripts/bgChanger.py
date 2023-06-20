import os
import time
import daemon

with daemon.DaemonContext():
    while True:
    
        os.system("feh --bg-fill --randomize $HOME/Pictures/bg/*")
        time.sleep(60)

