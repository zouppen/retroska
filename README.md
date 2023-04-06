
```
sudo podman build -t testi .
sudo podman run --hostname retroska --cap-add AUDIT_CONTROL -ti testi
```
