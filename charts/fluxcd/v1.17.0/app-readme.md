FluxCD
======

Flux is a tool that automatically ensures that the state of a cluster matches the config in git. It uses an operator in the cluster to trigger deployments inside Kubernetes, which means you don't need a separate CD tool. It monitors all relevant image repositories, detects new images, triggers deployments and updates the desired running configuration based on that (and a configurable policy).

This chart bootstraps a Flux deployment on a Kubernetes cluster using the Helm package manager.

Upstream Chart: [fluxcd chart](https://github.com/fluxcd/flux/tree/master/chart/flux)
