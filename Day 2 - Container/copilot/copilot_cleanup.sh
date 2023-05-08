#!/bin/bash

# ดึงค่าจาก cli และ loop เพื่อลบทีละตัว
for app in $(copilot app ls); do
    echo "Deleting app: $app"
    copilot app delete $app --yes
done

for svc in $(copilot svc ls | awk '{print $1}' | tail -n +3); do
    echo "Deleting service: $svc"
    copilot svc delete $svc --yes
done

for env in $(copilot env ls); do
    echo "Deleting environment: $env"
    copilot env delete $env --yes
done
