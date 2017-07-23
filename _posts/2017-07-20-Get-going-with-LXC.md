---
layout: default
title: Geting going with LXC
date: 2017-07-20 00:00:01
excerpt_separator: <!--more-->
tags:
---

This week I started learning about Kubernetes. Once it's up and running, Kubernetes is an orchestration layer that makes it really super straightforward to do rapid deployment, high availability, and scalability with Linux containers. I'm solid (enough) (for now) with Kubernetes (I see strong parallels with Cloud Foundry orchestration). But what's a Linux container? and can they be useful without Kubernetes?

<!--more-->
## What is Linux containers?

The stories that work for me won't work for everyone. So...

If you've ever wanted to run something in isolation on a Linux server or workstation (or device, or whatever) then learn how Linux containers can help you do that.

If you've ever found or put together an app and wanted to run it without messing up your network/language/shell settings then learn how Linux containers can help you do that.

[The intro on linuxcontainers.org](https://linuxcontainers.org/lxc/introduction/) and [the Wikipedia article](https://en.wikipedia.org/wiki/LXC) are good places to start.

## Using Linux containers

I'm doing this on a desktop PC running Ubuntu server. Apart from the package manager (e.g. `dnf`/`apt-get`/`yum`) and maybe the package names the steps appear to be consistent across distributions. Which seems good and reasonable, given we're not talking about Ubuntu or RedHat containers - we're talking about Linux containers.

### 1. Install LXC and templates
Probably the Linux kernel you're using was born knowing how to do containers. The `lxc` package provides commands you can use to tell the kernel what you'd like to accomplish (e.g. create, start, and stop your container).

Your container's going to need a root volume, processor, memory, and some other configurations. The `lxc-templates` package includes general-purpose templates of several different Linux distributions.

```
$ sudo apt-get install lxc lxc-templates
```

That made a bunch of suggestions so I sortof blindly also did:

```
$ sudo apt-get install cloud-utils-euca shunit2 wodim cdrkit-doc qemu-user-static lxctl
```

### 2. Configure LXC

Read - actually read - [the _Getting Started_ guide](https://linuxcontainers.org/lxc/getting-started/) before you start mashing keys and copy/pasting commands. It answers all the LXC questions I stubbed my toes on or bumped my head against.

_Sidenote: I wanted to run unprivileged containers, which [seems to not work in Fedora](https://ask.fedoraproject.org/en/question/87791/unprivileged-lxc/). That's why we're doing this on the Ubuntu server instead of on the Fedora laptop._

First, do a little recon...

```
$ grep $(whoami) /etc/sub?id
/etc/subgid:roger:165536:65536
/etc/subuid:roger:165536:65536
```

We're going to use that `165536` when we tell the kernel how to map UIDs and GIDs _inside_ the container to UIDs and GIDs _outside_ the container (see `lxc.id_map` below).

Now permit yourself to make LXC network interfaces, create the config file, and add the UID/GID mapping:

```
$ echo "$(whoami) veth lxcbr0 10" | sudo tee -a /etc/lxc/lxc-usernet
$ mkdir -p ~/.config/lxc
$ cp /etc/lxc/default.conf ~/.config/lxc/
$ cat >> ~/.config/lxc/default.conf <<EOM
> lxc.id_map = u 0 165536 65536
> lxc.id_map = g 0 165536 65536
> EOM
```

### 3. Create your container

Pick a template that suits your needs. I'm demonstrating this on Ubuntu so I'll create `my-container` from the CentOS template just to make it look different.

```
$ lxc-create -t download -n my-container -- -d centos -r 7 -a amd64
Setting up the GPG keyring
Downloading the image index
Downloading the rootfs
Downloading the metadata
The image cache is now ready
Unpacking the rootfs

---
You just created a CentOS container (release=7, arch=amd64, variant=default)

To enable sshd, run: yum install openssh-server

For security reason, container images ship without user accounts
and without a root password.

Use lxc-attach or chroot directly into the rootfs to set a root password
or create user accounts.
```

### 4. Start your container

Next up start the container and set the root password.

```
$ lxc-start -n my-container -d
$ lxc-ls --fancy
NAME         STATE   AUTOSTART GROUPS IPV4       IPV6
my-container RUNNING 0         -      10.0.3.154 -   
$ lxc-attach -n my-container -- passwd
Changing password for user root.
New password:
Retype new password:
passwd: all authentication tokens updated successfully.
```

### 5. Do .. something? with your container

For demonstration purposes I'm just going to compare `/etc/os-release` between the host:

```
$ egrep ^NAME /etc/*release*
/etc/os-release:NAME="Ubuntu"
```

And the container:

```
$ lxc-console -n my-container

Connected to tty 1
                  Type <Ctrl+a q> to exit the console, <Ctrl+a Ctrl+a> to enter Ctrl+a itself

CentOS Linux 7 (Core)
Kernel 4.4.0-83-generic on an x86_64

my-container login: root
Password:
[root@my-container ~]# egrep ^NAME /etc/*release*
/etc/os-release:NAME="CentOS Linux"
```

## See also

- https://linuxcontainers.org/lxc/getting-started/
- https://stgraber.org/2014/01/17/lxc-1-0-unprivileged-containers/
- http://blog.scottlowe.org/2013/11/25/a-brief-introduction-to-linux-containers-with-lxc/
