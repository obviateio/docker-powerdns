# PowerDNS Docker Container

[![Image Size](https://images.microbadger.com/badges/image/shakataganai/powerdns-remote.svg)](https://microbadger.com/images/shakataganai/powerdns-remote)
[![Docker Stars](https://img.shields.io/docker/stars/shakataganai/powerdns-remote.svg)](https://hub.docker.com/r/shakataganai/powerdns-remote/)
[![Docker Pulls](https://img.shields.io/docker/pulls/shakataganai/powerdns-remote.svg)](https://hub.docker.com/r/shakataganai/powerdns-remote/)
[![Docker Automated buil](https://img.shields.io/docker/automated/shakataganai/powerdns-remote.svg)](https://hub.docker.com/r/shakataganai/powerdns-remote/)

* Small Alpine based Image
* ONLY supports [remote](https://doc.powerdns.com/md/authoritative/backend-remote/) backend
* Guardian process enabled
* Graceful shutdown using pdns_control

## Supported tags

* Exact: i.e. `4.0.2-r3`: PowerDNS Version 4.0.2, image build 3
* `4.0`: PowerDNS Version 4.0.x, latest image build
* `4`: PowerDNS Version 4.x.x, latest image build

## Usage

```shell
$ docker run --name powerdns \
  -p 53:53 \
  -p 53:53/udp \
  --restart=always \
  -e REMOTE_CONNECTION_STRING="http:url=http://localhost:1234/dns" \
  -d shakataganai/powerdns-remote
```

## License

[GNU General Public License v2.0](https://github.com/PowerDNS/pdns/blob/master/COPYING) applyies to PowerDNS and all files in this repository.


## Maintainer

* Jon Davis <github@konsoletek.com>

### Credits

* Christoph Wiechert <wio@psitrax.de>
* Mathias Kaufmann <me@stei.gr>: Reduced image size
