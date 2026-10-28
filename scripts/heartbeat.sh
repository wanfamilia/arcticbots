#!/bin/bash
curl -s -b ~/.checkin_cookies "https://notify-vtqgf7mcma-uc.a.run.app?channel=heartbeat&msg=Checkin+$1"
