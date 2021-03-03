# docker-chrome-vpn
A docker container providing a Google Chrome with a Husarnet VPN Client to access Husarnet powered devices from a web browser without installing Husarnet Client on your host system.

Tested on host system:
```
  Operating System: Ubuntu 20.04.1 LTS
            Kernel: Linux 5.4.0-62-generic
      Architecture: x86-64
    Docker version: 20.10.5, build 55c4c88
```

## Create `.env` file

And specify Husarnet JoinCode and hostname there. It could look like this:

```
JOINCODE=fc94:b01d:1803:8dd8:3333:2222:1234:1111/xxxxxxxxxxxxxxxxx
HOSTNAME=my-container-1
```
You will find your JoinCode at **https://app.husarnet.com -> choosen network -> `[Add element]` button ->  `join code` tab**

## Build an image

Make sure `init-container.sh` is executable. If not:

Then build an image:
```bash
sudo docker build -t firefox-vpn .
```




## Start a container

### Linux

**NOTE**
Older versions of docker on Linux do not support `host.docker.internal`

```bash
xhost local:root
```

<!-- sudo docker run --rm -it --net=host -e DISPLAY -v /tmp/.X11-unix firefox -->
<!-- minimal: sudo docker run --rm -it --net=host --env DISPLAY firefox -->

```bash
sudo docker run --rm -it \
--env-file ./.env \
--env DISPLAY \
--volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
--volume my-container-1-v:/var/lib/husarnet \
--device /dev/net/tun \
--cap-add NET_ADMIN \
--sysctl net.ipv6.conf.all.disable_ipv6=0 \
firefox-vpn
```


### MacOS

```bash
xhost +localhost
```


```bash
sudo docker run --rm -it \
--env-file ./.env \
--env DISPLAY=host.docker.internal:1 \
--volume my-container-1-v:/var/lib/husarnet \
--device /dev/net/tun \
--cap-add NET_ADMIN \
--sysctl net.ipv6.conf.all.disable_ipv6=0 \
firefox-vpn
```