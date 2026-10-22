# NMOS Technical Overview
{:.no_toc}

- A markdown unordered list which will be replaced with the ToC, excluding the "Contents header" from above
{:toc}

> **Scope of this page:** This is an architectural guide to the Networked Media Open Specifications (NMOS), not a substitute for the normative text of an individual specification. The [NMOS specification index](https://specs.amwa.tv/nmos/) is the authoritative source for current versions, status and releases.

## What NMOS is

The Networked Media Open Specifications (NMOS) are a family of open, freely available specifications from the [Advanced Media Workflow Association (AMWA)](https://www.amwa.tv/) for interoperable control of professional media systems over IP networks.

NMOS standardizes the **control plane** around networked media resources. It gives devices and control applications shared models and APIs for:

- discovering resources and the APIs that provide them
- registering, querying and labelling resources
- connecting senders to receivers
- describing stream capabilities and compatibility
- carrying events and other time-related data
- configuring and monitoring devices
- securing control-plane communications and authorizing clients

NMOS is commonly deployed alongside [SMPTE ST 2110](https://www.smpte.org/standards/st2110) systems and is also relevant to IPMX and other IP-based media environments. It is not restricted to one media transport, codec, network topology or deployment model: the media plane may be on-premises, distributed across sites, or implemented partly in the cloud.

## What NMOS is not

NMOS is not a replacement for every technology in an IP media system. In particular, NMOS generally does not define:

- the media encoding, packetization or wire transport for a particular stream
- the physical network, switching, routing, bandwidth reservation or quality of service mechanisms
- the facility time-synchronization system, such as PTP
- a complete operational workflow or user interface
- the internal implementation of a device, registry or controller

Instead, NMOS provides interoperable control-plane building blocks and works with technologies from other standards bodies and industry groups. Format and transport mappings, such as those in the [BCP-006](https://specs.amwa.tv/bcp-006/) and [BCP-007](https://specs.amwa.tv/bcp-007/) series, describe how particular media technologies are represented through NMOS.

## The control-plane view

A useful way to understand an IP media system is to separate the concerns:

| Concern | Typical technologies or specifications | Role |
| --- | --- | --- |
| Media and data plane | RTP, SMPTE ST 2110, JPEG XS, NDI and others | Carries media or data between endpoints |
| Timing and synchronization | PTP and media-specific timing models | Establishes a common timebase and synchronization |
| NMOS control plane | IS-04, IS-05, IS-07 and the wider NMOS family | Describes, discovers, connects, configures and monitors resources |
| Network and facility services | DNS/DNS-SD, DHCP, LLDP, routing, QoS and security infrastructure | Provides the environment in which nodes operate |

NMOS does not require all systems to use multicast or RTP. For example, IS-07 event flows can use WebSockets or MQTT, and an implementation can use NMOS connection management for transports other than the commonly deployed RTP media flows. The relevant format and transport specifications still need to be followed for the media technology in use.

## The NMOS resource model

NMOS represents a media system as a graph of uniquely identified resources. The primary resources are:

| Resource | Meaning |
| --- | --- |
| **Node** | A logical host for one or more Devices. A Node can be physical, virtual, clustered or cloud-hosted. |
| **Device** | A logical block of functionality hosted by a Node, such as a camera, mixer, gateway or software process. |
| **Source** | The logical origin of one or more Flows. A Source is not necessarily the physical device that produced the content. |
| **Flow** | A sequence of timed Grains representing a rendition of a Source, such as video, audio or data. |
| **Sender** | Makes a Flow available through a particular transport. |
| **Receiver** | Consumes a Flow and describes the transport and formats it can accept. |
| **Grain** | A unit of timed essence or data within a Flow; a video frame is one common example. |

A single physical product can expose one Node containing several Devices, Sources, Flows, Senders and Receivers. Conversely, a Node or Device may be implemented as software and may not map one-to-one to a physical box.

Resources have UUIDs and are related to one another through the NMOS data model. For example, a camera Device may have a video Source and an audio Source, each with one or more Flows and Senders. A controller normally discovers the Sender and Receiver resources, then uses their associated Flow, Source, format, transport and capability information to decide whether a connection is appropriate.

The [MS-04 ID & Timing Model](https://specs.amwa.tv/ms-04/) documents the identity and timing concepts shared by NMOS specifications. The [NMOS Glossary](Glossary.md) provides shorter definitions of the terms used here.

## APIs and protocol conventions

NMOS APIs are designed to be usable with standard web and network tooling:

- HTTP APIs use resource-oriented, JSON representations and JSON Schema constraints.
- WebSockets are used where a long-lived subscription or event channel is useful, including query updates and IS-07 event transport.
- MQTT is an optional transport for IS-07 event flows where a brokered publish/subscribe model is appropriate.
- DNS-SD is used to locate API endpoints. It can be provided by multicast DNS-SD in small or ad-hoc systems, or by unicast DNS-SD in managed deployments.
- RAML, JSON Schema and normative text are published with the specifications, allowing API documentation and implementation tooling to be generated from machine-readable definitions.

The APIs are intentionally modular. A controller connecting two media endpoints may use IS-04 to discover them, IS-05 to make the connection, BCP-004 to evaluate capabilities, and a BCP-006 or BCP-007 mapping to interpret the stream parameters. There is no single monolithic “NMOS API”.

## A typical NMOS lifecycle

The exact sequence depends on the deployment profile, but a common registered-mode workflow is:

1. **Locate API endpoints.** A Node finds the IS-04 Registration API and a control application finds the Query, Connection and other relevant APIs using DNS-SD. The IS-04 peer-to-peer mode remains useful for small or ad-hoc systems; managed facilities commonly use a registry.
2. **Register resources.** A Node publishes its Node, Device, Source, Flow, Sender and Receiver resources to an IS-04 registry. Registration records are maintained using the Node's heartbeat and lease behaviour. A registry provides the Registration API for Nodes and the Query API for clients.
3. **Query and select.** A controller queries the registry for resources and follows the relationships between them. It can filter results and subscribe to changes rather than repeatedly scanning the complete resource set.
4. **Check compatibility.** The controller compares the selected Sender and Receiver, including their media parameters, transport, capabilities and any format-specific requirements. BCP-004 describes parametric capabilities; BCP-005, BCP-006 and BCP-007 provide mappings for capability, format and transport information. IS-11 can be used where sender and receiver media parameters need to be coordinated.
5. **Stage and activate a connection.** The controller uses the IS-05 Connection API to set transport parameters and request activation. IS-05 separates staged connection state from activation, allowing a group of changes to be applied at a defined time when the implementation supports that behaviour.
6. **Carry the flow.** The media or data then travels using the selected transport. NMOS metadata identifies the logical flow and the endpoint configuration; it does not replace the media-plane protocol.
7. **Operate, configure and monitor.** Depending on the device and use case, controllers can map audio channels with IS-08, carry events with IS-07, apply system parameters with IS-09, use the IS-12 control protocol and MS-05 control models, annotate resources with IS-13, back up or restore device configuration with IS-14, and consume the minimum sender/receiver status models in BCP-008.

### Registered mode and peer-to-peer mode

IS-04 supports both a registry-based model and a peer-to-peer discovery model. A registry is normally preferred where a facility needs a common view of resources, controlled topology, persistence and scalable queries. Peer-to-peer discovery can be useful for small systems, temporary setups or environments where introducing a registry is disproportionate.

The discovery mechanism and the registry implementation are separate concerns. IS-04 defines the APIs and behaviours; it does not prescribe the database, replication design or internal scaling architecture of a registry. Large deployments should also follow the requirements of the applicable system profile, such as [JT-NM TR-1001-1](https://www.jt-nm.org/tr-1001-1/), including its requirements for network services and registered operation.

## Specification families

The [live NMOS index](https://specs.amwa.tv/nmos/) groups the documents by theme and type. The following map is intended to show how the parts fit together; it is not a version matrix.

### Core interface specifications

| Specification | Function |
| --- | --- |
| [IS-04](https://specs.amwa.tv/is-04/) | Discovery and Registration: Node, registry and query APIs and the resource model used to describe media endpoints. |
| [IS-05](https://specs.amwa.tv/is-05/) | Device Connection Management: stages and activates connections between Senders and Receivers. |
| [IS-06](https://specs.amwa.tv/is-06/) | Network Control: an API for network-controller functions such as topology and flow control. The current catalog marks this specification as deprecated; deployments should check its status before adopting it. |
| [IS-07](https://specs.amwa.tv/is-07/) | Event and Tally: time-sensitive state and state-change data, carried using WebSockets or MQTT and connected using IS-05. |
| [IS-08](https://specs.amwa.tv/is-08/) | Audio Channel Mapping: channel-level operations such as mapping, swapping and muting. |
| [IS-09](https://specs.amwa.tv/is-09/) | System Parameters: provides global configuration parameters to Nodes so they can start and operate consistently in a system. |
| [IS-10](https://specs.amwa.tv/is-10/) | Authorization: obtains and uses access tokens so API servers can authorize client requests. |
| [IS-11](https://specs.amwa.tv/is-11/) | Stream Compatibility Management: allows media parameters to be coordinated between Senders and Receivers. |
| [IS-12](https://specs.amwa.tv/is-12/) | Control Protocol: an NMOS protocol for control of devices and their control models. |
| [IS-13](https://specs.amwa.tv/is-13/) | Annotation: allows control and monitoring applications to update resource labels, descriptions and tags. |
| [IS-14](https://specs.amwa.tv/is-14/) | Device Configuration: backs up and restores an NMOS Node's MS-05-02 model and can change rebuildable parts of that model where permitted. |

### Data models and control

- [MS-04](https://specs.amwa.tv/ms-04/) defines the shared ID and timing model for content-related NMOS specifications.
- [MS-05-01](https://specs.amwa.tv/ms-05-01/) defines the NMOS Control Architecture.
- [MS-05-02](https://specs.amwa.tv/ms-05-02/) defines the NMOS Control Framework, including the model used to describe controllable device functionality.
- [MS-05-03](https://specs.amwa.tv/ms-05-03/) defines rules for creating NMOS Control Block Specs and is currently work in progress.
- The [NMOS Control Feature Sets](https://specs.amwa.tv/nmos-control-feature-sets/) register provides opt-in models for control classes and data types derived from the NMOS Control Framework.

These models make it possible to add control functionality without changing the basic Node, Device, Sender and Receiver discovery model. A device advertises the services and models it implements, while a controller uses the corresponding specification and feature set to interpret them.

### Best Current Practices and mappings

Best Current Practices (BCPs) complement the interface specifications with recommendations and technology-specific mappings:

- [BCP-002 — Resource Annotation](https://specs.amwa.tv/bcp-002/) covers consistent annotation and grouping of resources.
- [BCP-003 — Security Recommendations](https://specs.amwa.tv/bcp-003/) covers secure communications, authorization and certificate provisioning. Its child documents include [BCP-003-01](https://specs.amwa.tv/bcp-003-01/), [BCP-003-02](https://specs.amwa.tv/bcp-003-02/) and [BCP-003-03](https://specs.amwa.tv/bcp-003-03/).
- [BCP-004 — Capabilities](https://specs.amwa.tv/bcp-004/) defines how endpoints express parametric capabilities and how controllers evaluate them.
- [BCP-005 — Capability Mappings](https://specs.amwa.tv/bcp-005/) maps technology-specific capabilities into NMOS capability mechanisms.
- [BCP-006 — Format Mappings](https://specs.amwa.tv/bcp-006/) describes how particular media formats are represented through NMOS, including compressed formats such as JPEG XS.
- [BCP-007 — Transport Mappings](https://specs.amwa.tv/bcp-007/) describes how particular transports are represented and connected through NMOS.
- [BCP-008 — Status Monitoring](https://specs.amwa.tv/bcp-008/) defines minimum status models for Senders and Receivers through [BCP-008-01](https://specs.amwa.tv/bcp-008-01/) and [BCP-008-02](https://specs.amwa.tv/bcp-008-02/).

The [NMOS Parameter Registers](https://specs.amwa.tv/nmos-parameter-registers/) hold shared values used by the specifications, such as format, transport and capability identifiers. Using registered values avoids vendor-specific strings where a common definition is needed, while the register process provides an extension path for new technologies.

## Security and trust

Security is part of the architecture, not an assumption that a media facility is isolated. Implementations should select and apply the relevant security profile for their environment:

- [BCP-003-01](https://specs.amwa.tv/bcp-003-01/) recommends TLS 1.2 or better for HTTP and WebSocket communications and defines interoperable secure-transport practice.
- [IS-10](https://specs.amwa.tv/is-10/) defines authorization using credentials and access tokens based on OAuth 2.0 and JSON Web Tokens.
- [BCP-003-02](https://specs.amwa.tv/bcp-003-02/) recommends use of IS-10 for authorization in NMOS systems.
- [BCP-003-03](https://specs.amwa.tv/bcp-003-03/) describes automated TLS server-certificate provisioning based on Enrollment over Secure Transport (EST, [RFC 7030](https://www.rfc-editor.org/rfc/rfc7030)).

A deployment also needs an identity, certificate, authorization and key-management design, as well as network controls appropriate to its risk profile. Enabling HTTPS alone does not decide which controller may change a connection or which operator may access a device. Conversely, authorization cannot protect credentials or requests if the transport is not secured.

## Versioning and profiles

NMOS specifications are independently versioned and published with both development branches and releases. Before implementing or procuring an API:

1. Select a released version from the [NMOS specification index](https://specs.amwa.tv/nmos/), rather than relying on a development branch.
2. Read the version-specific normative documentation, API definitions and schemas.
3. Check the versions and optional features required by the system profile or procurement specification.
4. Implement the API versioning and upgrade behaviour defined by that specification; do not infer compatibility from a URL or a product label alone.
5. Treat work-in-progress specifications as changing and confirm their status before depending on them in a product or facility.

A system profile such as TR-1001-1 constrains how a collection of specifications and network services are used together. NMOS conformance by itself does not guarantee that an implementation satisfies every requirement of such a profile.

## Implementation responsibilities

A practical deployment normally contains several types of component:

### NMOS Node

A Node exposes the APIs appropriate to the device and advertises its resources. It is responsible for maintaining resource identity, serving API responses, registering with the appropriate IS-04 mechanism, applying connection requests, and reporting the services and capabilities it supports.

### Registry and query service

A registry implements the IS-04 Registration and Query APIs. It accepts registrations from Nodes, expires resources that are no longer maintained, and provides filtered queries and change notifications to clients. IS-04 leaves storage and internal scaling to the implementation so that a registry can be adapted to the topology and operational requirements of the facility.

### Controller or application

A controller is an IS-04, IS-05 or other NMOS API client. It discovers resources, evaluates their relationships and capabilities, requests connections or device changes, and presents or automates the resulting workflow. NMOS does not require one particular controller product or user interface.

### Supporting infrastructure

The system must also provide the network and operational services required by its profile, including DNS-SD, IP addressing, routing and QoS, time synchronization, certificate and identity services, and monitoring. For an engineered ST 2110 environment, consult TR-1001-1 and the applicable SMPTE and network-engineering requirements in addition to NMOS.

## Interoperability, testing and adoption

The specifications are published with machine-readable API definitions, schemas, examples and documentation. Implementers should use the rendered version-specific documentation for conformance details and the source repository when they need the RAML, JSON Schema or examples.

AMWA's [NMOS Testing Tool](https://specs.amwa.tv/nmos-testing/) can exercise many NMOS API implementations. It is useful during development and interoperability events, but it does not replace system-level testing of media, timing, network behaviour, security and the chosen facility profile. The [NMOS CI Dashboard](https://specs.amwa.tv/nmos-dashboard/dashboard.html) and [NMOS Solutions](NMOS%20Solutions.md) page provide additional implementation and ecosystem information.

## A suggested implementation path

For a new implementation, the following order usually minimizes dependencies:

1. Define the Node, Device, Source, Flow, Sender and Receiver resources and allocate stable UUIDs.
2. Implement the required version of [IS-04](https://specs.amwa.tv/is-04/) and verify registration, query, heartbeat and discovery behaviour.
3. Implement [IS-05](https://specs.amwa.tv/is-05/) for the required transport and connection lifecycle.
4. Add the relevant [BCP-004](https://specs.amwa.tv/bcp-004/), format and transport mappings so controllers can make informed connection decisions.
5. Add secure communications and authorization using the applicable [BCP-003](https://specs.amwa.tv/bcp-003/) recommendations and [IS-10](https://specs.amwa.tv/is-10/).
6. Add optional capabilities required by the workflow, such as IS-07 events, IS-08 channel mapping, IS-11 compatibility, IS-12/MS-05 control, IS-14 configuration or BCP-008 status.
7. Test the implementation against the selected releases, profile requirements and real media/network conditions.

This staged approach is not a conformance statement: the required set of specifications depends on the product, system profile and procurement requirements.

## Further reading

- [NMOS specification index](https://specs.amwa.tv/nmos/)
- [AMWA NMOS overview](https://www.amwa.tv/nmos)
- [NMOS Introduction](Introduction.md)
- [NMOS FAQ](FAQ.md)
- [NMOS Glossary](Glossary.md)
- [JT-NM Reference Architecture](https://www.jt-nm.org/reference-architecture/)
- [JT-NM TR-1001-1](https://www.jt-nm.org/tr-1001-1/)
- [IPMX](https://ipmx.io/)
