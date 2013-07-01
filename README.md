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

[**Graphite**](http://graphite.readthedocs.org/en/latest/) is a
collection of daemons which collect, store, and render metrics for
you. It is split into separate components:

 * **carbon**, which collects metrics
 * **whisper**, which stores metrics on disk and automatically rolls
     up older metrics into a lower resolution to optimise disk usage
 * **graphite webapp**, which renders metrics into pretty graphs or
       JSON files

[**collectd**](http://collectd.org/) is a daemon which collects
system statistics and can output them to carbon. It has a large
number of plugins for common daemons. There are two ways to wire up
collectd communication:

 * Use the
   [write_graphite collectd plugin](https://collectd.org/wiki/index.php/Plugin:Write_Graphite)
   to submit metrics directly to carbon from each host machine
 * Use the
   [network collectd plugin](https://collectd.org/wiki/index.php/Plugin:Network)
   to connect client collectd daemons to a single server daemon on the
   `graphite` machine. The server then uses write_graphite to
   communicate locally to carbon.

Neither method is currently implemented in this module; issue #1 aims
to resolve this.

[**gstatsd**](https://github.com/phensley/gstatsd) is a daemon which
collects user-submitted metrics at an arbitrary rate, performs some
statistical massaging, and submits them to carbon at carbon's rigid
one-per-N-second rate. It is intended to receive metrics from
applications configured to use it. To create metrics on a machine in
this vagrant menagerie, run the command:

    echo -n 'my_metric_name.submetric:1|c' | nc -u localhost 8125

(note that as ubuntu's netcat is slightly interesting, you may have to
kill it with SIGINT; nevertheless, it will still submit the metric.)

#### Alternatives

Other tools which you may wish to consider:

 * [**diamond**](http://opensource.brightcove.com/project/diamond) is
   another system metric daemon in the same space as collectd
 * [**statsd**](https://github.com/etsy/statsd/) is the original
   daemon which gstatsd copies.

### Logging

The main tool is **rsyslog**. The main server is called `logging`; all
machines run rsyslog and submit their log events to the central
logging server. The submitted logs will appear on `logging` in
`/srv/log`.


