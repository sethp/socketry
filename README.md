# Socketry

A portmanteu of Socket and Wizardry. We'll see if that pans out.

Something something "socket activation."

## Running

```
make bin/server
./hack/run.sh
```

and

```
curl --unix-socket ./service.sock
```

## Rough Sketch

Zero downtime deployments by way of socket passing between processes. The trick is that I want to do this with containers, also: to start with, the listening socket exists at the host namespace but the receiving process should run within its own context.

At this point, I expect the architecture to be roughly: listening daemon outside the container, spawns a container that has a socket, passes the fd(s) over the socket to a process inside the container that then execs the listening process.

### Questions

- How does passing fds between namespaces work?
- Can we effectively use "run once" mode here? A program that takes a single fd and writes Stuff to it is very easy to build.
- What about "run for a while
- <something forgotten here>
- Boldly: can we do something cross-machine? Much larger project, that.

## References

- https://kevincox.ca/2021/04/15/my-ideal-service/
- https://github.com/coreos/go-systemd/tree/v14/examples/activation/httpserver
- https://tailordev.fr/blog/2017/06/09/deploying-a-go-app-with-systemd-socket-activation/
- https://vincent.bernat.ch/en/blog/2018-systemd-golang-socket-activation
- https://copyconstruct.medium.com/file-descriptor-transfer-over-unix-domain-sockets-dcbbf5b3b6ec
  - and the referenced paper https://research.fb.com/publications/zero-downtime-release-disruption-free-load-balancing-of-a-multi-billion-user-website/
