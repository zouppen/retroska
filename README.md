# Retroska

Podman container which has all the funky 90s services for your network
such as:

* FTP server
* Samba (Windows for Workgroups 3.11 compatible)
* IRC

## Roadmap

See issues for planned features.

## Installation

Requires Podman, not compatible with Docker since systemd is required
inside the container.

To build and run:

```sh
podman build -t testi .
podman run --rm=true --cap-add AUDIT_CONTROL,NET_ADMIN,NET_RAW --hostname retroska -v retro:/mnt -e RETRO_WORKGROUP=RETRO -ti testi
```

**TODO** better instructions.

## Networking

The bare minimum is a physical Ethernet adapter or VLAN interface to
your vintage network. It is advised to be a segregated network without
modern computers or especially IoT appliances for security reasons.

Internet access inside the container is optional but practical; it
allows reaching online FTP servers and connecting multiple Retroskas
together for a larger LAN party.

There are multiple ways to do networking in Podman. If you use Podman
in rootful mode and have a bridge already and have Podman 4, you may
consider using `--network` switch multiple times in `podman run` to
provide Internet interface and the vintage network.

However, using rootless mode works for this container quite well. We
are using the default slirp4netns network for Internet access and then
push one physical (or VLAN) Ethernet adapter to the container. That
part requires root access, but only once after startup.

To push an Ethernet interface to the rootless container you can use
script `push_if`. By default it pushes the interface to the last
container lauched, but you can specify it. To push network interface
`ethX` to container called `my_retroska`, run:

```sh
./push_if ethX my_retroska
```

It asks the password for sudo. If you've got no `sudo`, adapt the
script to your needs.

Please keep in mind that the interface stays in the container only
during the execution. In case of VLAN device, Linux destroys the
interface after container is stopped. In case of physical interface,
it is returned back to the host.

**TODO** Provide systemd scripts for running the container with the
network. Test it with Podman 4

## Architecture

See [Architecture wiki
page](https://github.com/zouppen/retroska/wiki/Architecture). It
describes how containers should be designed and has some community
guidelines as well.

NB. I'm open for good tips how to use the force of Podman more
efficiently but don't want to listen to any rants about using systemd
with containers (or without).
[There are good arguments on RedHat site](https://developers.redhat.com/blog/2019/04/24/how-to-run-systemd-in-a-container#enter_podman).

## Contributing

Please contribute to my design paper: https://demo.hedgedoc.org/3Ev8GPbVTQWT_pdJOudFNQ#

## Kudos

Thanks to [Paul Holzinger](https://github.com/Luap99) for pointing me
this [Rootless Networking
presentation](https://podman.io/community/meeting/notes/2021-10-05/Podman-Rootless-Networking.pdf). It
helped a lot in understanding how to transfer interfaces to
non-privileged containers.
