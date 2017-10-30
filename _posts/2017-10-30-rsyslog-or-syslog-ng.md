---
layout: default
title: rsyslog? or syslog-ng?
date: 2017-10-30 00:00:01
excerpt_separator: <!--more-->
tags:
---

You probably have several smart devices around your home: Computer, phone, TV, game console, cable/DSL modem, router, and so on. How would it be if you could see in one place what they've all been doing?

You could aggregate all their logged events with [rsyslog](http://www.rsyslog.com/) or [syslog-ng](https://syslog-ng.org/), then filter, parse, and report on them. Maybe they're interesting enough to deserve interactive visualizations like you can build with [Kibana](https://www.elastic.co/products/kibana).

To start with, though, have a peek at [syslog-ng](https://syslog-ng.org/) and [rsyslog](http://www.rsyslog.com/)...

<!--more-->

# How do syslog-ng and rsyslog compare?

Both [rsyslog](http://www.rsyslog.com/) and [syslog-ng](https://syslog-ng.org/) will accept `syslog` events on the network. Both support, via plugins, various outputs (for example write to files, database, or queues), filters, and text transformations.

If you're new to log aggregation, like I am, it could be hard to choose one to start with. Even when you look down the road to, for example, interactive visualizations and machine learning, you'll see ways to do what you want with both syslog-ng and rsyslog.

While I explored both projects I figured I'd put my hands on them. And, of course, I took notes...

# Install the current release

I prefer to muck about with disposable Linux containers.

For example, to create and log in to an Ubuntu 16.04 container:

```
lxc-create -t download -n sysloggin -- -d ubuntu -r xenial -a amd64
lxc-start -n sysloggin
lxc-attach -n sysloggin -- passwd ubuntu
lxc-attach -n sysloggin -- login ubuntu
```

And to clean it up after:

```
# `exit` out of your container
lxc-stop -n sysloggin
lxc-destroy -n sysloggin
```

## rsyslog

[The _Installing rsyslog_ section of the project's README.md](https://github.com/rsyslog/rsyslog/blob/master/README.md#installing-rsyslog) explains that rsyslog development moves too fast for Linux distributions' repos, and suggests using the project's repos for the latest rsyslog goodness.

Let's try both...

### The version included with Ubuntu

```
$ rsyslogd -v
rsyslogd 8.16.0, compiled with:
	PLATFORM:				x86_64-pc-linux-gnu
	PLATFORM (lsb_release -d):		
	FEATURE_REGEXP:				Yes
	GSSAPI Kerberos 5 support:		Yes
	FEATURE_DEBUG (debug build, slow code):	No
	32bit Atomic operations supported:	Yes
	64bit Atomic operations supported:	Yes
	memory allocator:			system default
	Runtime Instrumentation (slow code):	No
	uuid support:				Yes
	Number of Bits in RainerScript integers: 64

See http://www.rsyslog.com for more information.
```

### The version from adiscon's repo

To get the latest stable release, [rsyslog's _Ubuntu Repository_ guide](http://www.rsyslog.com/ubuntu-repository/) says to:

> 1. Open a Terminal
> 2. Enter the following command:
>     ```
>     sudo add-apt-repository ppa:adiscon/v8-stable
>     ```
>     If you want to add the repositories  manually [(not recommended) follow this link.](http://www.rsyslog.com/ubuntu-repository-legacy/)
> 3. Then update your apt cache:
>     ```
>     sudo apt-get update
>     ```
> 4. Finally install the new rsyslog version:
>     ```
>     sudo apt-get install rsyslog
>     ```

_Note: `add-apt-repository` was unavailable in my Ubuntu template until I installed `software-properties-common` as suggested [on askubuntu.com](https://askubuntu.com/questions/493460/how-to-install-add-apt-repository-using-the-terminal#493467) and in [the rsyslog README on GitHub.com](https://github.com/rsyslog/rsyslog/blob/5bc999cbc6419b854d97103960be0daccb733577/README.md#ubuntu)._

```
sudo apt-get install software-properties-common
sudo apt update
sudo apt upgrade
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:adiscon/v8-stable
sudo apt-get update
sudo apt-get install rsyslog
```

```
$ rsyslogd -v
rsyslogd 8.30.0, compiled with:
	PLATFORM:				x86_64-pc-linux-gnu
	PLATFORM (lsb_release -d):		
	FEATURE_REGEXP:				Yes
	GSSAPI Kerberos 5 support:		No
	FEATURE_DEBUG (debug build, slow code):	No
	32bit Atomic operations supported:	Yes
	64bit Atomic operations supported:	Yes
	memory allocator:			system default
	Runtime Instrumentation (slow code):	No
	uuid support:				Yes
	Number of Bits in RainerScript integers: 64

See http://www.rsyslog.com for more information.
```

### What changed between 8.16.0 and 8.30.0?

To view code changes you can [compare the tags on GitHub.com](https://github.com/rsyslog/rsyslog/compare/v8.16.0...v8.30.0). To read about those changes you can [review the changelog](https://github.com/rsyslog/rsyslog/blob/4ad43b448a23a713492907405b43f8125a4c60b5/ChangeLog#L114-L1563).

## syslog-ng

[The _Installing from Binaries_ section of the project's README.md](https://github.com/balabit/syslog-ng/blob/master/README.md#installation-from-binaries) suggests using your Linux distribution's packages and mentions that the "latest versions of syslog-ng are available for a wide range of Debian and Ubuntu releases and architectures from an [unofficial repository](https://build.opensuse.org/project/show/home:laszlo_budai:syslog-ng)".

Let's try both...

### The version available in Ubuntu

```
$ sudo apt update
$ sudo apt upgrade
$ sudo apt install syslog-ng
$ syslog-ng --version
syslog-ng 3.5.6
Installer-Version: 3.5.6
Revision: 3.5.6-2.1 [@416d315] (Ubuntu/16.04)
Compile-Date: Oct 24 2015 03:49:19
Available-Modules: tfgeoip,afmongodb,confgen,dbparser,afsocket-tls,csvparser,basicfuncs,afprog,afstomp,afamqp,cryptofuncs,system-source,linux-kmsg-format,affile,afsocket,afsmtp,afsql,redis,json-plugin,afsocket-notls,syslogformat,afuser
Enable-Debug: off
Enable-GProf: off
Enable-Memtrace: off
Enable-IPv6: on
Enable-Spoof-Source: on
Enable-TCP-Wrapper: on
Enable-Linux-Caps: on
Enable-Pcre: on
```

### The version from the unofficial repo

Just now, the latest in the unofficial repo is [3.12.1](https://build.opensuse.org/package/show/home:laszlo_budai:syslog-ng/syslog-ng-3.12). A search and a click got me to [the instructions](https://www.balabit.com/blog/installing-the-latest-syslog-ng-on-ubuntu-and-other-deb-distributions/):

> 1\. Download and install the release key:
>
> ```
> wget -qO - http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/xUbuntu_17.04/Release.key | sudo apt-key add -
> ```
>
> 2\. Add the repository containing the latest unofficial build of syslog-ng to the APT sources. Under the /etc/apt/sources.list.d/ directory create a new file, for example syslog-ng-obs.list. Add the following line to this file:
>
> ```
> deb http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/xUbuntu_16.10 ./
> ```
>
> Run the following command:
>
> ```
> apt-get update
> ```
>
> 3\. Install syslog-ng and any of its subpackages:
>
> ```
> apt-get install syslog-ng-core
> ```

Adjusted a bit for my Ubuntu Xenial container image:

```
sudo apt install wget
wget -qO - http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/xUbuntu_16.04/Release.key | sudo apt-key add -
echo 'deb http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/xUbuntu_16.04 ./' | sudo tee /etc/apt/sources.list.d/syslog-ng-obs.list
sudo apt update
# syslog-ng 3.5.6 was already installed, so upgrade it
sudo apt upgrade
```

### What changed between 3.5.6 and 3.12.1?

To view code changes you can [compare the tags on GitHub.com](https://github.com/balabit/syslog-ng/compare/v3.5.6...syslog-ng-3.12.1). The [Open Source Edition documentation](https://www.balabit.com/sites/default/files/documents/syslog-ng-ose-latest-guides/en/syslog-ng-ose-guide-admin/html/index.html) includes [_What is new in syslog-ng Open Source Edition_](https://www.balabit.com/sites/default/files/documents/syslog-ng-ose-latest-guides/en/syslog-ng-ose-guide-admin/html/syslog-ng_whatsnew.html) and [_Changes in product_ back to 3.10](https://www.balabit.com/sites/default/files/documents/syslog-ng-ose-latest-guides/en/syslog-ng-ose-guide-admin/html/ose-changes.html)

# How do you make them work?

## Configure rsyslog [server]()

## Configure syslog-ng [server](https://www.balabit.com/sites/default/files/documents/syslog-ng-ose-latest-guides/en/syslog-ng-ose-guide-admin/html/concepts-server-mode.html)

_See [Configuring syslog-ng on server hosts](https://www.balabit.com/sites/default/files/documents/syslog-ng-ose-latest-guides/en/syslog-ng-ose-guide-admin/html/configure-servers.html) in the quick-start guide for more information._

The default configuration in `/etc/syslog-ng/syslog-ng.conf` seems pretty inclusive. To simplify the configuration for testing, replace it with this one from [the quick-start guide](https://www.balabit.com/sites/default/files/documents/syslog-ng-ose-latest-guides/en/syslog-ng-ose-guide-admin/html/configure-servers.html):

_Note: I changed `perm(0777)` to `perm(0770)` and `transport(tcp)` to `transport(udp)`._

```
@version: 3.12
@include "scl.conf"
    options {
        time-reap(30);
        mark-freq(10);
        keep-hostname(yes);
        };
    source s_local { system(); internal(); };
    source s_network {
        syslog(transport(udp));
        };
    destination d_logs {
        file(
            "/var/log/syslog-ng/logs.txt"
            owner("root")
            group("root")
            perm(0770)
            ); };
    log { source(s_local); source(s_network); destination(d_logs); };
```

My `/var/log/syslog-ng` directory did't exist yet, so I created it and restarted syslog-ng:

```
mkdir -m 774 /var/log/syslog-ng
sudo systemctl restart syslog-ng
```

The next time I tried `logger` it told me, "logger: socket /dev/log: Connection refused". Without looking too far into that I did `lxc-stop`/`lxc-start` to reboot the container. After that, logging seemed to work:

```
$ logger 'user ubuntu writes a message'
$ sudo tail -n 3 /var/log/syslog-ng/logs.txt
Oct 30 00:58:15 syslog-ng sudo[197]: pam_unix(sudo:session): session opened for user root by LOGIN(uid=0)
Oct 30 00:58:15 syslog-ng sudo[197]: pam_unix(sudo:session): session closed for user root
Oct 30 00:58:48 syslog-ng LOGIN[200]: user ubuntu writes a message
```

While troubleshooting a "What port is it listening on?" problem I configured the firewall. I'm unsure whether this was necessary. Here it is anyway:

```
sudo apt install ufw
sudo ufw enable
sudo ufw allow 514
```

## Configure a syslog source

For initial testing I used `nc` per the _DIY client_ section below. You can run rsyslog and syslog-ng in client mode, or configure your native syslog to forward messages to your rsyslog or syslog-ng server.

### [rsyslog client]()

### [syslog-ng client](https://www.balabit.com/sites/default/files/documents/syslog-ng-ose-latest-guides/en/syslog-ng-ose-guide-admin/html/concepts-client-mode.html)

### DIY client

My first real use case will be a device that forwards log messages to the server's UDP port 514, so I configured rsyslog and syslog-ng to listen on UDP port 514. This `nc` example [from byexamples.com](http://linux.byexamples.com/archives/412/syslog-sending-log-from-remote-servers-to-syslog-daemon/) successfully demonstrated function:

```
nc -w0 -u YourServerAddress 514 <<< "<14>Your message here."
```

## Send some syslog

Quickly and simply demonstrate that your syslog server is receiving and recording log entries.

### rsyslog

### syslog-ng

```
ubuntu@aclient:~$ nc -w0 -u 10.0.3.202 514 <<< "<14>woooo a message from a remote host"
```

```
ubuntu@syslog-ng:~$ sudo grep woooo /var/log/syslog-ng/logs.txt
Oct 30 02:44:07 aclient woooo a message from a remote host
```



## Now what?

- - - -
# Why I'm starting out with syslog-ng

You'll make your own choice, to suit your own needs. For me it was easy, and it wasn't about superior features or capabilities, nor ease of use:

More than just a product to use, I'm also looking for a project to contribute to. For both purposes, I find syslog-ng more welcoming.
