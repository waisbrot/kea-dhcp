FROM ubuntu:focal

ARG KEA_VERSION=1-6

RUN apt-get update \
  && apt-get install -y apt-transport-https curl gnupg \
  && curl -1sLf "https://dl.cloudsmith.io/public/isc/kea-${KEA_VERSION}/cfg/gpg/gpg.0607E2621F1564A6.key" | apt-key add - \
  && curl -1sLf "https://dl.cloudsmith.io/public/isc/kea-${KEA_VERSION}/cfg/setup/config.deb.txt?distro=ubuntu&codename=xenial" > /etc/apt/sources.list.d/isc-kea.list \
  && apt-get install -y kea-dhcp4-server
RUN cp /etc/kea/kea-dhcp4.conf /etc/kea.json \
  && mkdir -p /run/kea \
  && touch /run/kea/logger_lockfile

ENTRYPOINT ["/usr/sbin/kea-dhcp4", "-c", "/etc/kea.json"]
