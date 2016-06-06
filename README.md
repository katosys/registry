# docker-registry

[![Build Status](https://travis-ci.org/h0tbird/docker-registry.svg?branch=master)](https://travis-ci.org/h0tbird/docker-registry)

Containerized Docker registry service

##### Certificate

```
mkdir certs && openssl req \
-newkey rsa:4096 -nodes -sha256 -x509 -days 365 \
-subj '/CN=127.0.0.1/O=Localhost LTD./C=US' \
-keyout certs/server-key.pem -out certs/server-crt.pem
```

##### Registry

```
docker run -it --rm \
--net host --name registry \
--volume ${PWD}/certs:/certs \
--env REGISTRY_LOG_LEVEL=debug \
--env REGISTRY_HTTP_DEBUG_ADDR=127.0.0.1:5001 \
--env REGISTRY_HTTP_SECRET=$(openssl rand -hex 64) \
--env REGISTRY_HTTP_TLS_CERTIFICATE=/certs/server-crt.pem \
--env REGISTRY_HTTP_TLS_KEY=/certs/server-key.pem \
--env REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY=/var/lib/registry \
--env REGISTRY_AUTH_TOKEN_REALM=http://127.0.0.1/v2/token \
--env REGISTRY_AUTH_TOKEN_SERVICE=127.0.0.1:5000 \
--env REGISTRY_AUTH_TOKEN_ISSUER=127.0.0.1 \
--env REGISTRY_AUTH_TOKEN_ROOTCERTBUNDLE=/certs/server-crt.pem \
--env SSL_TRUST=foo:443,bar:443 \
--env ENDPOINT_NAME=portus \
--env ENDPOINT_URL=http://127.0.0.1/v2/webhooks/events \
--env ENDPOINT_TIMEOUT=500 \
--env ENDPOINT_THRESHOLD=5 \
--env ENDPOINT_BACKOFF=1 \
h0tbird/registry:latest
```

Verify the status of the registry:

```
curl -s http://127.0.0.1:5001/debug/health | jq '.'
curl -s http://127.0.0.1:5001/debug/vars | jq '.'
```
