#!/bin/bash
set -e

api_password=$(grep api-key /var/vcap/jobs/pdns/etc/pdns.conf | sed 's/api-key=//g')
payload='{"name":"smoke-testing.org.", "kind": "Master","dnssec":false,"soa-edit":"INCEPTION-INCREMENT","masters": [], "nameservers": ["ns1.smoke-testing.org."]}'

printf "setting a test zone\n"
curl --silent --fail --request POST --header "X-API-Key: ${api_password}" --data "$payload" http://127.0.0.1:8081/api/v1/servers/localhost/zones
printf "\ngetting the test zone\n"
curl --silent --fail --request GET --header "X-API-Key: ${api_password}" http://127.0.0.1:8081/api/v1/servers/localhost/zones/smoke-testing.org.
printf "\ndeleting the test zone\n"
curl --silent --fail --request DELETE --header "X-API-Key: ${api_password}" http://127.0.0.1:8081/api/v1/servers/localhost/zones/smoke-testing.org.
printf "\nerrand has finished\n"
