#!/usr/bin/env bash

 cat ../key/mendel_rsa.pub | ssh mshahbaz@$1.stanford.edu "mkdir -p ~/.ssh && touch ~/.ssh/authorized_keys && chmod -R go= ~/.ssh && cat >> ~/.ssh/authorized_keys"