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

```
podman build -t testi .
podman run --hostname retroska --cap-add AUDIT_CONTROL,NET_ADMIN,NET_RAW --network=ns:/run/netns/retro -e RETRO_WORKGROUP=RETRO -ti testi
```

**TODO** better instructions.

### Setting up network namespaces

The bare minimum is a physical Ethernet adapter or VLAN interface to
your vintage network. It is advised to be a segregated network without
modern computers or especially IoT appliances for security reasons.

Internet access inside the container is optional but practical; it
allows reaching online FTP servers and connecting multiple Retroskas
together for a larger LAN party.

There are multiple ways to do networking in Podman. If you use podman
in rootful mode and have a bridge already and have Podman 4, you may
consider using `--network` switch multiple times in `podman run` to
provide Internet interface and the vintage network.

However, using rootless mode work for this container quite well. We
are using the default slirp4netns network for Internet access and then
push one physical (or VLAN) Ethernet adapter to the container. That
part requires root access, but only once after startup.

To push an Ethernet interface to the rootless container you can use
script `push-if`. By default it pushes the interface to the last
container lauched, but you can specify it. To push network interface
`ethX` to container called `my_retroska`, run:

```sh
./push_if ethX my_retroska
```

It asks the password for sudo. If you've got no sudo, adapt the
script to your needs.

Please keep in mind the interface push lasts only during the
run-time. In case of VLAN device, Linux destroys the interface. In
case of physical interface, it returns back to the host use.

**TODO** Provide systemd scripts for running the container with the
network. Test it with Podman 4

## Architecture

Instead of more complex orchestration I've chosen to implement this as
monolithic container using Podman and systemd. Systemd does good job
in monitoring process status and in this case I don't even want heavy
separation of services since for example files are shared multiple
ways: FTP, Samba among others.

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
