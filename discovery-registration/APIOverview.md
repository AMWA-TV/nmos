# AMWA NMOS Discovery and Registration Specification: API Overview

_(c) AMWA 2016, CC Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)_

## Introduction

Nodes (logical hosts) expose one or more APIs:

* The [Node API](APIs/NodeAPI.raml) is present on all Nodes to provide a means of finding the resources on each Node. The Node API also plays an important role in [Peer-to-peer discovery](P2POperation.md), and is expected to be used by future NMOS specifications, e.g. for connection management.
* The [Registration](APIs/RegistrationAPI.raml) and [Query](APIs/QueryAPI.raml) are present on Nodes that enable registry-based discovery, as discussed in the [NMOS Technical Overview](../NMOS Technical Overview.md)

## Requirements on Nodes

A Node (logical host) MUST implement the [Node API](APIs/NodeAPI.raml).

A Node MUST attempt to interact with the [Registration API](APIs/RegistrationAPI.raml).

Optionally, Nodes MAY implement [Peer-to-peer discovery](P2POperation.md) in order to permit continued operation on a link-local only, or smaller network deployment. Nodes requiring data about other Nodes in the system MUST obtain this via the Query API if available, or using the Peer-to-peer specification in smaller networks (if implemented).

## mDNS Bridging
For clients which need to discover the services of a Query API, but operate in software such as web browsers where mDNS is unsupported, it is suggested that a bridging service is employed to present the mDNS data via an HTTP service (or similar).

## API Specifications
The Node, Registration and Query APIs are specified using:
* The following sub-sections describing common API properties.
* [RAML](http://raml.org/) documents and [JSON schemas](http://tools.ietf.org/html/draft-zyp-json-schema-04) in the [APIs/](APIs/) folder.

Examples of JSON format output are provided in the [examples](examples/) folder.

### Content Types
All APIs MUST provide a JSON representation signalled via 'Content-Type: application/json' headers. This SHOULD be the default content type in the absence of any requested alternative by clients. Other content types (such as HTML) are permitted if they are explicitly requested via Accept headers.

### API Path
All NMOS APIs MUST use a path in the following format. Other HTTP resources MAY be presented on the same port by the Node, provided all NMOS resources are available from the /x-nmos/ path as follows:

```
http(s)://<ip address or hostname>:<port>/x-nmos/<api type>/<api version>/
```

At each level of the API from the base resource upwards, the response SHOULD include a JSON format array of the child resources available from that point.

### Versioning
All public APIs are versioned as follows:

* Requesting the API base resource (such as http(s)://<ip address or hostname>:<port>/x-nmos/query/) will provide a list containing the versions of the API present on the node.

### Common API Base Resource
```
[
  "v1.0/",
  "v2.0/",
  "v3.0/"
]
```

* Appending /v1.0/ to the API base resource will request version 1.0 of the API if available.
* The versioning format is v<#MAJOR>.<#MINOR>
* MINOR increments SHOULD be performed for non-breaking changes (such as the addition of attributes in a response)
* MAJOR increments MUST be performed for breaking changes (such as the renaming of a resource or attribute)
* Versions MUST be represented as complete strings. Parsing MUST proceed as follows: separate into two strings, using the point (.) as a delimiter. Compare integer representations of MAJOR, MINOR version (such that v1.12 is greater than v1.5).
* Clients are responsible for identifying the correct API version they require.

### URLs: Approach to Trailing Slashes
* If a client performs a GET or HEAD request it SHOULD correctly handle a 301 response (moved permanently).
* The client MUST follow the 301 redirect in order to retrieve the required resource.

### Error Handling
All APIs make full use of HTTP status codes including the likes of 201 and 204 for success cases, and a JSON response SHOULD be included where indicated by the specification. For HTTP codes 400+, a JSON format response MUST be returned as follows:

**Example Error Response**
```
{
  "code": 400,
  "error": "Human readable message which is suitable for user interface display, and helpful to the user",
  "debug": "Programmer / debugging detail or traceback"
}
```

In the above example, the 'code' should always match the HTTP status code. 'error' must always be present and in string format. 'debug' may be null if no further debug information is available.

### Cross-Origin Resource Sharing (CORS)
In order to permit web control interfaces to be hosted remotely, all NMOS APIs MUST implement valid CORS HTTP headers in responses, and respond to HTTP pre-flight OPTIONS requests. In order to simplify development, the following headers are routinely returned in order to remove these restrictions as far as possible. Note that these are very relaxed and may not be suitable for a production deployment.

```
Access-Control-Allow-Origin: *
Access-Control-Allow-Methods: GET, PUT, POST, HEAD, OPTIONS, DELETE
Access-Control-Allow-Headers: Content-Type, Accept
Access-Control-Max-Age: 3600
```

To ensure compatibility, the response 'Access-Control-Allow-Headers' could be set from the request's 'Access-Control-Request-Headers'.

## Common API Keys
A number of common keys are used within NMOS APIs. Their definitions, required practices for interpretation and permitted values are described below.

### Version
Core resources such as Sources, Flows, Nodes etc. include a 'version' attribute. As properties of a given Flow or similar will change over its lifetime, the version identifies the instant at which this change took place. For example, if a vision mix transition occurred which resulted in a change to the 'parents' which make up a particular Flow, the 'version' should be modified to reflect the wall clock instant at which this change occurred.

The version is a nanosecond TAI timestamp represented as a string of the format: <seconds>:<nanoseconds>. Note the ':' as opposed to a '.', indicating that the value '1439299836:10' should be interpreted as 1439299836 seconds and 10 nanoseconds.

Combining the version with the resource's ID attribute creates a hash which can be used to uniquely identify a particular variant of a Source, Flow or similar.

### Label
Freeform human readable string to be used within user interfaces.

### Description
Freeform human readable string to be used within user interfaces.

### Format
A URN describing the data format of a video, audio or data flow.

| **Permitted Value**         | **Valid From API Version** |
|-----------------------------|----------------------------|
| urn:x-nmos:format:video | v1.0                       |
| urn:x-nmos:format:audio | v1.0                       |
| urn:x-nmos:format:data  | v1.0                       |

NB: Sub-classifications of these core URNs may also be encountered within this API version (such as urn:x-nmos:format:video.raw), and should still be interpreted correctly by consumers up to the boundaries above.

### Transport
A URN describing the protocol used to send data (video, audio, data etc.) over a network.

| **Permitted Value**                | **Valid From API Version** |
|------------------------------------|----------------------------|
| urn:x-nmos:transport:rtp       | v1.0                       |
| urn:x-nmos:transport:rtp.mcast | v1.0                       |
| urn:x-nmos:transport:rtp.ucast | v1.0                       |
| urn:x-nmos:transport:dash      | v1.0                       |

For example, an RTP Transmitter sending to a multicast group should use the transport 'urn:x-nmos:transport:rtp.mcast', but a receiver supporting both unicast and multicast should present the transport 'urn:x-nmos:transport:rtp' to indicate its less restrictive state.

Manufacturers MAY use their own namespaces to indicate transports which are not defined within the NMOS namespace at a particular API version, but should support be added in a future version the NMOS variant MUST be used when upgrading to that API version.

### Tags
A set of keys and values providing a means to filter resources based on particular categorisations. Each tag has a single key, but MAY have multiple values. Each tags SHOULD be interpreted using the comparison of a single key value pair, with the comparison being case-insensitive following the Unicode Simple Case Folding specification.

**Example: Tags Format**
```
{
  "tags": {
    "location": ["Salford", "Media City"],
    "studio": ["HQ1"],
    "recording": ["The Voice UK"]
  }
}
```

### Type (Devices)

| **Permitted Value**            | **Valid From API Version** |
|--------------------------------|----------------------------|
| urn:x-nmos:device:generic  | v1.0                       |
| urn:x-nmos:device:pipeline | v1.0                       |
