#!/bin/bash

echo "[pypi: $(date)]: htpasswd -b -c /pypi-server/auth/.htpasswd PYPI_USER=$PYPI_USER PYPI_PASS=*****"
htpasswd -b -c /pypi-server/auth/.htpasswd "$PYPI_USER" "$PYPI_PASS"

echo "[pypi: $(date)]: pypi-server -p 80 -v --log-file /var/log/pypi-server.log -P /pypi-server/auth/.htpasswd -a update,download,list ./packages"
pypi-server run -p 80 -v --log-file /var/log/pypi-server.log -P /pypi-server/auth/.htpasswd -a update,download,list ./packages
