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

  sed -i "s|{{ LDAP_BASE_DN }}|${LDAP_BASE_DN}|g"   /etc/ldap/ldap.conf
  sed -i "s|{{ LDAP_ROOT_DN }}|${LDAP_ROOT_DN}|g"   /etc/ldap/ldap.conf
  sed -i "s|{{ LDAP_ROOT_PW }}|${LDAP_ROOT_PW}|g"   /etc/ldap/ldap.conf
  sed -i "s|{{ LDAP_BIND_URI }}|${LDAP_BIND_URI}|g" /etc/ldap/ldap.conf
  sed -i "s|{{ LDAP_BIND_DN }}|${LDAP_BIND_DN}|g"   /etc/ldap/ldap.conf
  sed -i "s|{{ LDAP_BIND_PW }}|${LDAP_BIND_PW}|g"   /etc/ldap/ldap.conf

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
