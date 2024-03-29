# CloudNet-Installer


**This repo is inspired and modified code of [CloudNet-Installer](https://github.com/GiantTreeLP/CloudNet-Installer) from [GaintTreeLP](https://github.com/GiantTreeLP)**

---
[![Github Actions](https://github.com/TheMeinerLP/CloudNet-Installer/actions/workflows/os-testing.yml/badge.svg)](https://github.com/TheMeinerLP/CloudNet-Installer/actions/workflows/os-testing.yml)

[![GitHub issues](https://img.shields.io/github/issues/TheMeinerLP/CloudNet-Installer.svg)](https://github.com/TheMeinerLP/CloudNet-Installer/issues)
[![GitHub stars](https://img.shields.io/github/stars/TheMeinerLP/CloudNet-Installer)](https://github.com/TheMeinerLP/CloudNet-Installer/stargazers)
[![GitHub license](https://img.shields.io/github/license/TheMeinerLP/CloudNet-Installer)](https://github.com/TheMeinerLP/CloudNet-Installer)


Installer for the [Cloud Network Environment Technology](https://github.com/CloudNetService/CloudNet-v3).

Uses [`pacapt`](https://github.com/icy/pacapt) for compatibility with as many distributions as possible.

## Version

The installer installs the latest stable build of the CloudNet software.

## Prequisites

[`curl`](https://curl.haxx.se/) has to be available to be able to download additional files.  
[`bash`](https://www.gnu.org/software/bash/) is necessary for `pacapt` to work. This script has also only been tested with bash.

### Debian-based distributions (Debian, Ubuntu, Linux Mint):

Just run this code before installing CloudNet:

    apt update && apt install curl -y

### Alpine-based distributions:

You need to add `curl` and `bash` manually:

    apk add curl bash -y --no-cache

## Installation

Simply copy and paste the following code into your shell:

    curl -sL "https://themeinerlp.github.io/CloudNet-Installer/install.sh" | bash

Launching the installer as the `root` user checks and installs all necessary dependencies.  
Launching the installer as a non-root user skips this step.

## Compatibility

All tests have been conducted with the slim images available for Docker, where possible.

| Distribution   | Version                   | Tested/Compatible |
| :------------- | :------------------------ | :---------------- |
| **Debian**     | testing                   | ✅                 |
| Debian         | 11 (Bullseye)             | ✅                 |
| Debian         | 10 (Buster)               | ✅                 |
| Debian         | 9 (Stretch)               | ✅                 |
| Debian         | 8 (Jessie)                | ✅                 |
| **Ubuntu**     | 20.04 (Focal Fossa)       | ✅                 |
| Ubuntu         | 18.04 (Bionic Beaver)     | ✅                 |
| Ubuntu         | 16.04 (Xenial Xerus)      | ✅                 |
| Ubuntu         | 14.04 (Trusty Tahr)       | ✅                 |
| **Alpine**     | 3.9                       | ✅                 |
| Alpine         | 3.8                       | ✅                 |
| Alpine         | 3.7                       | ✅                 |
| **Arch Linux** | Rolling                   | ✅                 |
| **CentOS**     | 7                         | ✅                 |
| **Fedora**     | 35                        | ✅                 |
| Fedora         | 34                        | ✅                 |
| Fedora         | 33                        | ✅                 |
| Fedora         | 32                        | ✅                 |
| Fedora         | 31                        | ✅                 |
| Fedora         | 30                        | ✅                 |
| Fedora         | 29                        | ✅                 |
| Fedora         | 28                        | ✅                 |
| Fedora         | 27                        | ✅                 |
| Fedora         | 26                        | ✅                 |