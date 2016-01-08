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
