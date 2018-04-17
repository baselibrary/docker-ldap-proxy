FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

ENV LDAP_URI="ldap://ldap.thoughtworks.io:389"
ENV LDAP_SUFFIX="DC=corporate,DC=thoughtworks,DC=com"
ENV LDAP_BIND_DN="CN=yourname,OU=Xian,OU=Employees,OU=Enterprise,OU=Principal,DC=corporate,DC=thoughtworks,DC=com"
ENV LDAP_BIND_PW="yourpassword"

RUN \
  apt-get update &&\
  apt-get install -y slapd ldap-utils

COPY ldap.conf /etc/ldap/ldap.conf

## Scripts
ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod a+x docker-entrypoint.sh

EXPOSE 389

ENTRYPOINT ["/docker-entrypoint.sh"]

VOLUME ["/var/lib/slapd"]

CMD ["slapd", "-d", "1024", "-f", "/etc/ldap/ldap.conf"]
