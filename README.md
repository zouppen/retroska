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
podman run --hostname retroska --cap-add AUDIT_CONTROL -e RETRO_WORKGROUP=RETRO -ti testi
```

**TODO** better instructions.

**TODO** network configuration.

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
