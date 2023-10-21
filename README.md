# KhulnaSoft Dependency Packaging

This repository contains build definitions for a number of images that are components of the official and development images of KhulnaSoft.

The builds are currently hosted in GitHub Actions, but can be ported to any other container-based CI system.

Portability between CI systems and ability to run locally is critical, that's why some of these images are preferred over pre-packaged GitHub Actions.
Also, pre-package action often download dependencies on-the-fly, potentially increasing build times and causing flakiness. Registry is a network
resource, which could be unreliable at times, however it can be mirrored easily, unlike GitHub releases.
Some of the image do depend on GitHub releases or other HTTP blob storage providers, but there is no easy way around that, as the only alternative
would be to build all of the dependencies from source, which is not feasible.