#!/bin/bash
export FACTER_type=${TYPE_PUPPET};cd /etc/puppet/manifests;/opt/puppetlabs/bin/puppet apply site.pp
