FROM baselibrary/baseimage:2.0.0

ENV LDAP_BASE_DN="DC=thoughtworks,DC=io"
ENV LDAP_ROOT_DN="CN=admin,DC=thoughtworks,DC=io"
ENV LDAP_ROOT_PW="password"
ENV LDAP_BIND_URI="ldap://ldap.thoughtworks.io:389"
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
