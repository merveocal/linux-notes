#!/bin/bash

echo "==================================================="
echo "		USER-CREATED GROUPS LISTER (v1.0)"
echo "===================================================="
printf "%-15s | %-6s | %-20s\n" "GROUP NAME" "GID" "CREATION DATE (EST)"
echo "----------------------------------------------------"

awk -F: '$3 >= 1000 && $3 < 65534 {print $1 ":" $3}' /etc/group | while read -r line; do
	GROUP_NAME=$(echo  "$line" | cut -d: -f1)
	GROUP_ID=$(echo "$line" | cut -d: -f2)

	LOGA_DATE=$(grep "new group: name=$GROUP_NAME" /var/log/auth.log 2>/dev/null | head -n 1 | awk '{print $1, $2, $3}')

	if [ -z "$LOG_DATE" ]; then
		LOG_DATE="N/A (Log not found)"

	fi

	printf "%-15s | %-6s | %-20s\n" "$GROUP_NAME" "$GROUP_ID" "$LOG_DATE"
done

echo "======================================================"
echo "Show only custom groups created on this system"

