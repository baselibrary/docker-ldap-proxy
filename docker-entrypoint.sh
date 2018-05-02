#!/bin/bash

#enable job control in script
set -e -m

#####   variables  #####

# add command if needed
if [ "${1:0:1}" = '-' ]; then
  set -- slapd "$@"
fi

#run command in background
if [ "$1" = 'slapd' ]; then
  ##### pre scripts  #####
  echo "========================================================================"
  echo "initialize:"
  echo "========================================================================"

  sed -i "s|{{ LDAP_SUFFIX }}|${LDAP_SUFFIX}|g"             /etc/ldap/ldap.conf
  sed -i "s|{{ LDAP_ADMIN_DN }}|${LDAP_ADMIN_DN}|g"         /etc/ldap/ldap.conf
  sed -i "s|{{ LDAP_ADMIN_PW }}|${LDAP_ADMIN_PW}|g"         /etc/ldap/ldap.conf
  sed -i "s|{{ LDAP_PROXY_SOURCE }}|${LDAP_PROXY_SOURCE}|g" /etc/ldap/ldap.conf
  sed -i "s|{{ LDAP_PROXY_TARGET }}|${LDAP_PROXY_TARGET}|g" /etc/ldap/ldap.conf
  sed -i "s|{{ LDAP_PROXY_URI }}|${LDAP_PROXY_URI}|g"       /etc/ldap/ldap.conf
  sed -i "s|{{ LDAP_PROXY_DN }}|${LDAP_PROXY_DN}|g"         /etc/ldap/ldap.conf
  sed -i "s|{{ LDAP_PROXY_PW }}|${LDAP_PROXY_PW}|g"         /etc/ldap/ldap.conf

  ##### run scripts  #####
  echo "========================================================================"
  echo "startup:"
  echo "========================================================================"
  exec "$@" &

  ##### post scripts #####
  echo "========================================================================"
  echo "configure:"
  echo "========================================================================"

  #bring command to foreground
  fg
else
  exec "$@"
fi
