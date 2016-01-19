#------------------------------------------------------------------------------
# Set the base image for subsequent instructions:
#------------------------------------------------------------------------------

FROM registry:2.2.1
MAINTAINER Marc Villacorta Morera <marc.villacorta@gmail.com>

#------------------------------------------------------------------------------
# Environment variables:
#------------------------------------------------------------------------------

ENV CEPH_VERSION="infernalis"

#------------------------------------------------------------------------------
# Install librados2
#------------------------------------------------------------------------------

RUN apt-get update && apt-get install -y wget && \
    wget -q -O- 'https://download.ceph.com/keys/release.asc' | apt-key add - && \
    echo deb http://ceph.com/debian-${CEPH_VERSION}/ trusty main | \
    tee /etc/apt/sources.list.d/ceph-${CEPH_VERSION}.list && \
    apt-get update && apt-get install -y librados2 && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#------------------------------------------------------------------------------
# Populate root file system:
#------------------------------------------------------------------------------

ADD rootfs /

#------------------------------------------------------------------------------
# Expose ports and entrypoint:
#------------------------------------------------------------------------------

EXPOSE 5000
ENTRYPOINT ["/init"]
