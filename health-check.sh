#!/bin/bash
set -euo pipefail

# VeroGuard Health Check Script
# Version: 1.0.0

SERVICES=("nginx" "ssh" "cron")
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
FAILED=0

echo "=== VeroGuard Health Check ==="
echo "Timestamp: $TIMESTAMP"
echo ""

for SERVICE in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$SERVICE" 2>/dev/null; then
        echo "OK:   $SERVICE is running"
    else
        echo "FAIL: $SERVICE is not running"
        FAILED=$((FAILED + 1))
    fi
done

echo ""
if [ $FAILED -gt 0 ]; then
    echo "WARNING: $FAILED service(s) need attention"
    exit 1
else
    echo "All services healthy"
    exit 0
fi