FROM baselibrary/baseimage:2.0.0

RUN \
  apt-get update &&\
  apt-get install -y slapd ldap-utils

EXPOSE 389 636

VOLUME ["/var/lib/slapd"]

CMD ["slapd", "-d", "256", "-f", "/etc/ldap/slapd.d"]
