#!/bin/bash
lsusb -vv 2>/dev/null | grep -P "Bus [0-9]+ Device [0-9]+|bcdUSB|iManufacturer|iProduct|wSpeedsSupported|Device can operate at|Powered|MaxPower"
