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

We need at least the segregated network for vintage computers (so
called retro network) but you might like the ability to connect to the
Internet as well, so adding another network is advised.

There are multiple ways to do this. If you have a bridge already and
have Podman 4, consider it by using `--network` switch multiple times
in `podman run`. Since I'm still stuck with Podman 3, here are the
instructions for it.

You need one Ethenet interface for the private retro computer
network. It can be either physical Ethernet adapter or VLAN.  The
interface must be called `retro` for it to work with routing and DHCP,
so first we're doing renaming.

In case you are running systemd-networkd on the host or some other
facility which allows you to set custom permanent names for
interfaces, I suggest you to call the private retro computer network
`retro`. If not, then you can rename it temporarily by running:

```sh
ip link set name retro dev OLD_NAME
```

In the following example `retro` is used for both the namespace and
the Ethernet interface. To create the namespace and move the interface
there, run:

```sh
ip link set name retro dev ethX
ip netns add retro
ip link set netns retro dev retro
```

Also, Internet needs to be provided to the container if you want the
retro computers to be able to connect to the external world. You can use
bridge but for simple cases `slirp4netns` is easy enough. Let's launch it:

```sh
slirp4netns -c --netns-type=path /run/netns/retro internet
```

Make a script for them since they'll disappear every boot.

**TODO** Provide systemd network and service for them and/or Podman 4
instructions.

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
