# Peer-to-Peer discovery

_(c) AMWA 2016, CC Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)_

This document describes usage of NMOS APIs for discovery in cases where where a distributed registry is not available, such as small ad-hoc installations.

## Pre-Requisites
* All Nodes advertise their presence via mDNS at all times
* In the absence of a network registry, all Nodes additionally advertise a series of mDNS TXT records indicating the validity of their API resources
Both of the above are properties of the Node API and require no additional implementation steps.

## Behavioural Example
The following scenario describes a peer-to-peer discovery in which a Node features an onboard control interface (for example a display with an input source menu).

* Node comes online
* Node scans for an active Query API on the network (mDNS type '_nmos-query._tcp')
* Given no active Query API, Node scans mDNS for other Nodes (mDNS type '_nmos-node._tcp')
* Using the returned list of Nodes, the requesting Node may request data from remote Node API resources as required in order to populate a control interface. This may be as simple as requesting the '/senders' resource.
* The Node continues to monitor for changes to Node advertisements via mDNS. When Node API resources are changed, the TXT records associated with each Node will be updated to indicate which API resource(s) have been updated (see Node API specification)
* The Node does not re-poll remote Nodes on a timer in order to gather data about updated API resources
* The Node can perform connection management tasks automatically without user intervention provided they only affect that Node's operation. This includes but is not limited to automatically routing video from a discovered Sender to a display's Receiver

If a Query API becomes available on the network during peer-to-peer operation, the Node modifies its behaviour in one of the following two ways:
* The control interface switches to communicating with the network Query API rather than polling Nodes directly
* The control interface exposed to the user is disabled (if Query API interactions are not supported)

## Recommendations for Dual-Mode Operation

To allow both peer-to-peer operation and operation using a distributed Query API, it is recommended that:
* When collecting data from other Nodes in peer-to-peer mode, Nodes should populate an interface which replicates the structure of a Query API, but restricted to access from localhost only, with no Query API mDNS advertisement.
* When a network Query API becomes available, the localhost-based Query API may proxy requests through to the network Query API in order to provide a transparent transition to the client interface.

## Implementation Note
Due to the caching mechanisms present within mDNS implementations, if a Node disappears from the network without cleanly removing its mDNS announcement, it will still be present in the caches of peer-to-peer systems until the defined expiry time (120 second to 75 minutes dependent on record type). When mDNS advertised data is found to be invalid (for example by performing an HTTP request to an advertised Node API and seeing a timeout), the procedure defined in RFC6762 section 10.2 should be followed. Additionally, RFC6762 section 10.5 may be used to pre-empt these failures.
