---
layout: default
title: Getting going with LXC
date: 2017-10-07 00:00:01
excerpt_separator: <!--more-->
tags:
---

This summer I started learning about Kubernetes. Once it's up and running, [Kubernetes](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/) is an orchestration layer that makes it really super straightforward to do rapid deployment, high availability, and scalability with Linux containers. That sounds fantastic! But .. what's a Linux container? and can they be useful without Kubernetes?

<!--more-->
(edited and reposted on 7 Oct 2017)



## What is Linux containers?

[The intro on linuxcontainers.org](https://linuxcontainers.org/lxc/introduction/) and [the Wikipedia article](https://en.wikipedia.org/wiki/LXC) are good places to start answering this question.

The answer is huge, though. So: Think about what you'd like to do with Linux containers, and focus first on the bits that seem relevant.

If you've ever wanted to run a service (like a web server) in isolation on a Linux server or workstation (or device, or whatever) then learn how Linux containers can help you do that.

If you've ever found or made an application and wanted to run it without messing up your network/language/shell settings then learn how Linux containers can help you do that.



## Using Linux containers

Read - actually read - [the _Getting Started_ guide](https://linuxcontainers.org/lxc/getting-started/) before you start mashing keys and copy/pasting commands. It answers all the LXC questions I stubbed my toes on or bumped my head against.

The examples in this post are from a desktop PC running Ubuntu server. Apart from the package manager (e.g. `dnf`/`apt`/`yum`), and maybe the package names, the steps appear to be consistent across distributions.

### 1. Install LXC and templates

Probably the Linux kernel you're using was born knowing how to do containers. The `lxc` package provides commands you can use to tell the kernel what you'd like to accomplish (e.g. create, start, and stop your container).

Your container's going to need a default root volume and some other configurations. The `lxc-templates` package includes general-purpose templates.

```
$ sudo apt install lxc lxc-templates
```

(optional) When I ran that it made a bunch of suggestions so I sortof blindly also did:

```
$ sudo apt install cloud-utils-euca shunit2 wodim cdrkit-doc qemu-user-static lxctl
```

### 2. Configure LXC

_Sidenote: The steps in this post create unprivileged containers, which [seems to not work in Fedora](https://ask.fedoraproject.org/en/question/87791/unprivileged-lxc/). That's why we're looking at this on the Ubuntu server instead of on the Fedora laptop._

#### 2.1. Find your sub-UIDs and sub-GIDs

First, find out which sub-UID and sub-GID ranges are available to your user:

```
$ grep $USER /etc/sub?id
/etc/subgid:roger:165536:65536
/etc/subuid:roger:165536:65536
```

The lines in `/etc/subuid` and `/etc/subgid` each describe a starting value and a count. In the output above `roger` has 65536 sub-UIDs and 65536 sub-GIDs available, each starting from 165536.

If your user has no sub-UID and sub-GID mappings then add them:

```
sudo usermod --add-subuids 165536-231072 $USER
sudo usermod --add-subgids 165536-231072 $USER
grep $USER /etc/sub?id
```

For more info on sub-UIDs and sub-GIDs, check out:

- [`man 7 user_namespaces`](http://man7.org/linux/man-pages/man7/user_namespaces.7.html)
- [`man 5 subuid`](http://man7.org/linux/man-pages/man5/subuid.5.html)
- [`man 5 subgid`](http://man7.org/linux/man-pages/man5/subgid.5.html)

#### 2.2. Write your LXC configuration

Pick a range from your sub-UIDs, and one from your sub-GIDs, and tell the kernel to map UID and GID `0` _inside_ the container to your sub-UIDs and sub-GIDs _outside_ the container:

```
$ mkdir -p ~/.config/lxc
$ cp /etc/lxc/default.conf ~/.config/lxc/
$ cat >> ~/.config/lxc/default.conf <<EOM
> lxc.id_map = u 0 165536 65536
> lxc.id_map = g 0 165536 65536
> EOM
```

The `lxc.id_map` lines above tell LXC to map UID and GID `0` (`root`) _inside_ the container to your user's sub-UIDs and sub-GIDs in the range of `165536` to `231072`.

#### 2.3. Permit yourself to make LXC network interfaces

```
$ echo "$USER veth lxcbr0 10" | sudo tee -a /etc/lxc/lxc-usernet
```

### 3. Create your container

Pick a template that suits your needs. I'm demonstrating this on Ubuntu so I'll create `my-container` from the CentOS template just to make it look different.

If you run this `lxc-create` command:

```
lxc-create -t download -n wakka
```

It will create a new container called "wakka" and prompt you to select a Distribution, Release, and Architecture. Remember your choices, so next time you run `lxc-create` you can include your selections with the command:

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

Start your container and set the root password:

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

### 6. Do something (aka "Step 5, take two")

#### Connect to the container's console (`lxc-console`)

```
$ lxc-console -n my-container

Connected to tty 1
                  Type <Ctrl+a q> to exit the console, <Ctrl+a Ctrl+a> to enter Ctrl+a itself

CentOS Linux 7 (Core)
Kernel 4.4.0-93-generic on an x86_64

my-container login: root
Password:
Last login: Sat Jul 22 02:07:13 on pts/0
[root@my-container ~]# exit
logout
```

#### Disconnect from the container's console (`<Ctrl+a> <q>`)

```
CentOS Linux 7 (Core)
Kernel 4.4.0-93-generic on an x86_64

my-container login: <Ctrl+a> <q>
```

#### Stop the container (`lxc-stop`)

```
$ lxc-stop -n my-container
```

### 7. Clean up after yourself

#### Delete a container (`lxc-destroy`)

```
$ lxc-ls
fedora       my-container wakka
$ lxc-destroy -n wakka
Destroyed container wakka
$ lxc-ls
fedora       my-container
```

#### Remove the downloaded templates

This is optional, in case you're watching your used space. You'll only need these templates while you're creating containers, so you can remove them when you're done.

```
# There's gotta be a better way to do this.
$ rm -rf ~/.cache/lxc/download/*
```



## See also

- https://linuxcontainers.org/lxc/getting-started/
- https://stgraber.org/2014/01/17/lxc-1-0-unprivileged-containers/
- http://blog.scottlowe.org/2013/11/25/a-brief-introduction-to-linux-containers-with-lxc/
