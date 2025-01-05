# transmission-lan

This is a Docker Compose file to create a transmission container that has an IP on the local network.

# Quick Start

1. Modify the IPv4 addresses in `compose.yaml` to match your local network and assign a static IP to the container.
1. Modify the `parent` to match the name of the network interface of the host.
1. Modify the volume `source` paths to match your expected layout.  Delete any that are not needed.
1. Import or start the container.
