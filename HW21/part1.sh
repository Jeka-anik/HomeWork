#!/bin/bash
df -h | grep "/dev/vda5" | awk '{print $3/$2}' 
