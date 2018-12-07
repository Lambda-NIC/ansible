#!/bin/bash
/sbin/ethtool --coalesce enp94s0np1 rx-usecs 1
/sbin/ethtool --coalesce enp94s0np1 tx-usecs 1
/sbin/ethtool --coalesce enp94s0np1 rx-frames 1
/sbin/ethtool --coalesce enp94s0np1 tx-frames 1
