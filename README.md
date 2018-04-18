## ThoughtWorks Docker Image: ldap-proxy

### Base Docker Image

* `latest`: ldap-proxy 1.0.0
* `1.0.0` : ldap-proxy 1.0.0 (ubuntu 14.04)

### Installation

    docker pull baselibrary/ldap-proxy

### Usage

    docker run -d -p 389:389 -e LDAP_BIND_DN="CN=yourname,DC=thoughtworks,DC=com" -e LDAP_BIND_PW="yourpassword" baselibrary/ldap-proxy:1.0.0
