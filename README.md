# knative
Anleitung für knative in k3d auf linux

## Installation des Clusters
$ chmod 777 ./install-knative.sh
$ ./install-knative.sh

## Installation des Services
Warten bis alle Pods ready sind
$ kubectl get pods -n knative-serving

$ chmod 777 ./install-service.sh
$ ./install-service.sh

## Aufruf des Services
$ curl http://hello.default.127.0.0.1.sslip.io

## Installation der Function
$ chmod 777 ./install-function.sh
$ ./install-function.sh

## Aufruf der Function
$ curl http://demo.default.127.0.0.1.sslip.io

## Installation des Eventings
$ kn broker create default
$ kn service create event-display --image gcr.io/knative-releases/knative.dev/eventing/cmd/event_display
$ kn trigger create all-events --sink event-display --broker default
$ kn source ping create ping --schedule "*/1 * * * *" --data '{message:"Hello from PingSource"}' --sink "http://event-display.default.svc.cluster.local"

## Troubleshooting
Are you seeing curl: (6) Could not resolve host: hello.default.127.0.0.1.sslip.io?

In some cases your DNS server may be set up not to resolve *.sslip.io addresses. If you encounter this problem, it can be fixed by using a different nameserver to resolve these addresses.

The exact steps will differ according to your distribution. For example, with Ubuntu derived systems which use systemd-resolved, you can add the following entry to the /etc/systemd/resolved.conf:

[Resolve]
DNS=8.8.8.8
Domains=~sslip.io.
Then simply restart the service with sudo service systemd-resolved restart.