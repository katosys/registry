# docker-registry

[![Build Status](https://travis-ci.org/h0tbird/docker-registry.svg?branch=master)](https://travis-ci.org/h0tbird/docker-registry)

Containerized Docker registry service

##### RADOS Storage backend

If you plan to use a RADOS pool as storage backend I recommend you to create the `/` object before starting the Docker registry:

```
core@core-1 ~ $ ceph osd pool create registry-ext 64
core@core-1 ~ $ rados -p registry-ext put / /dev/null
core@core-1 ~ $ rados ls -p registry-ext | grep '^/$'
/
```

##### TLS cert and key

```
openssl req \
-subj '/CN=domain.com/O=My Company Name LTD./C=US' \
-new \
-newkey rsa:2048 \
-days 365 \
-nodes \
-x509 \
-keyout certs/server.key \
-out certs/server.crt
```

##### Registry

```
docker run -it --rm \
--net host \
--volume ${PWD}/certs:/certs \
--env REGISTRY_LOG_LEVEL=info \
--env REGISTRY_HTTP_SECRET=long-secret-goes-here \
--env REGISTRY_HTTP_TLS_CERTIFICATE=/certs/server.crt \
--env REGISTRY_HTTP_TLS_KEY=/certs/server.key \
--env REGISTRY_STORAGE_DELETE_ENABLED=true \
--env REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY=/var/lib/registry \
--env ENDPOINT_NAME=portus \
--env ENDPOINT_URL=http://127.0.0.1/v2/webhooks/events \
--env ENDPOINT_TIMEOUT=500 \
--env ENDPOINT_THRESHOLD=5 \
--env ENDPOINT_BACKOFF=1 \
h0tbird/registry:latest
```
