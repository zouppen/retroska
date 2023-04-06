# Retroska

Podman container which has all the funky 90s services for your network
such as:

* FTP server
* Samba (Windows for Workgroups 3.11 compatible)
* IRC

And some modern ones:

* SFTP

## Installation

Requires Podman, not compatible with Docker since systemd is required
inside the container.

To build and run:

```
sudo podman build -t testi .
sudo podman run --hostname retroska --cap-add AUDIT_CONTROL -ti testi
```

**TODO** better instructions.

**TODO** network configuration.

**TODO** add convincing arguments to calm down container purits who are against systemd.
