# monitoring-inabox

This is an example project to demonstrate implementing various
monitoring capacities using Puppet. Its aims are twofold:

 * Suggest modules which are easy to get going with
 * Provide an example usage of those modules to show how to use them

## Getting started

You will need [Ruby](http://www.ruby-lang.org/) (ideally from
[rbenv](https://github.com/sstephenson/rbenv)) and
[Bundler](http://gembundler.com/). You will also need
[Vagrant](http://www.vagrantup.com/) version >= 1.1.

A simple `Vagrantfile` is provided to spin up separate VMs playing
different roles in the monitoring environment. To show the available
machines, run `vagrant status`. To provision particular machines, run
`vagrant up <name>`. For example, to explore gstatsd and its
submission of metrics to graphite, you probably want the `graphite`
and `node1` machines.

To log into a machine, run `vagrant ssh <name>`.

## Batteries included

Here are the headline details of what's inside.

### Metrics

The main tools are **graphite**, **collectd** and **gstatsd**. The
main server is called `graphite`, while all machines run gstatsd and
collectd. The gstatsd instances all submit their metrics to the
internal graphite server.

### Logging

The main tool is **rsyslog**. The main server is called `logging`; all
machines run rsyslog and submit their log events to the central
logging server. The submitted logs will appear on `logging` in
`/srv/log`.
