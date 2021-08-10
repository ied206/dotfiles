#!/bin/bash
sudo lspci -vv | grep -P "[0-9a-f]{2}:[0-9a-f]{2}\.[0-9a-f]|LnkSta:|LnkCap:"

