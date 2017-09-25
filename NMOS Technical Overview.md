# NMOS Technical Overview

_(c) AMWA 2017, CC Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)_

For the latest version of this document please go to https://github.com/AMWA-TV/nmos.


[comment]: <> (ToC goes after this comment. Create it with "gh-md-toc --hide-header --depth=3")

* [NMOS Technical Overview](#nmos-technical-overview)
  * [Introduction](#introduction)
    * [Background](#background)
    * [General Principles](#general-principles)
  * [NMOS Model and Glossary](#nmos-model-and-glossary)
  * [The Specifications](#the-specifications)
    * [Discovery and Registration Proposed Specification (IS\-04)](#discovery-and-registration-proposed-specification-is-04)
    * [Content Model WIP Specification](#content-model-wip-specification)
    * [In\-stream Signaling of Identity and Timing information for RTP streams WIP Specification](#in-stream-signaling-of-identity-and-timing-information-for-rtp-streams-wip-specification)
    * [Device Connection Management WIP Specification](#device-connection-management-wip-specification)
    * [Network Control WIP Specification](#network-control-wip-specification)
  * [NMOS Data Model Overview](#nmos-data-model-overview)
    * [Node](#node)
    * [Devices](#devices)
    * [Sources, Flows and Grains](#sources-flows-and-grains)
    * [Senders and Receivers](#senders-and-receivers)
  * [Accessing a Node's resources](#accessing-a-nodes-resources)
  * [Timing](#timing)
  * [Example System Architecture](#example-system-architecture)
    * [Node Structure](#node-structure)
  * [Registering and Discovering Nodes](#registering-and-discovering-nodes)
    * [Peer\-to\-Peer Discovery](#peer-to-peer-discovery)
    * [Registered Model](#registered-model)
    * [Examples](#examples)
  * [Connection Management](#connection-management)
  * [Content Transport](#content-transport)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc.go)


[comment]: <> (ToC goes before this comment)


## Introduction

Networked Media Open Specifications ([NMOS]) are a family of specifications that support the professional AV media industry's transition to a "fully-networked" architecture. The NMOS specs are developed by the Advanced Media Workflow Association ([AMWA]) and are published on GitHub.

### Background

While much of the broadcast industry has moved to file-based operation, live facilities have long depended on specialist technologies such as the [Serial Digital Interface] (SDI), [SMPTE Timecode] and various incompatible control protocols (including some using RS-232, some of which are still in use).  However (as of 2017) there is a significant move towards replacing these with more general IT/IP technologies, allowing the industry to benefit from the high speeds and economies of scale that have enabled the success of the Internet and Web.

Standards bodies including SMPTE and AES have created specifications for streaming of uncompressed video and audio over IP.  These use RTP and include [ST 2022-6] for SDI-based payloads, [AES-67] for audio-only payloads and the forthcoming [ST 2110] for separate video, audio and ancillary data over IP.  However none of these tackle the control or application planes, leaving significant additional work to be done to achieve useful interoperability in professional networked media environments. So a number of industry bodies came together in 2013 on the Joint Task Force on Networked Media ([JT-NM]) to coordinate how this might happen. This led to the creation of a "reference architecture" for interoperability ([JT-NM RA]). At its most basic this identifies models and best practices for what may be needed at four layers: operation, application, platform and infrastructure.

![JT-NM Layers](images/jtnm-layers.png)

This is where the Advanced Media Workflow Association ([AMWA]) comes in.  AMWA is an industry group of manufacturers, developers and end users, that is trying to advance a software-focussed approach to support future professional media operations.  What this means in practice is identifying how to build upon "commodity" infrastructure (red layer) and widely used platform technologies/protocols (green) layer and supplement these where required with helpful specifications that build upon these building blocks.  AMWA has done this in the past with "application specifications" for file-based interchange and delivery, and is now doing this for networked media with the NMOS specifications, which are being created by AMWA's Networked Media Incubator group. These provide a open set of APIs to support interoperability for networked media applications:


![JT-NM Layers with NMOS APIs](images/jtnm-layers-nmos.png)

### General Principles

When creating NMOS specifications we try to follow a number of general principles, which will be familiar to today's developers.

#### Web-friendly protocols

In the past specialised wire protocols have often been used for the control plane within facilities.  However networked media operations are becoming increasingly distributed across locations, and sometimes across organisational boundaries, including third-party/public cloud providers.  So it is desirable to use protocols that are aimed at such environments. HTTP and WebSockets are examples of these, and this is what NMOS currently uses.

There is a huge amount of work happening in the wider IT/IP industry on optimising these protocols and their implementation, making previous arguments about the performance of specialised protocols less relevant.

#### Developer-friendly APIs

A decade ago, typical control APIs used an "RPC-style" approach based on SOAP, XML, XSD and WSDL, leading to quite complex code and messages. Modern developers of web APIs typically use a REST (or at least "REST-like"—see below) approach with simpler messages based on JSON and a lightweight approach to schemas using e.g. RAML and JSON Schema.  

NMOS adopts this modern approach.

#### REST

Although "REST" is often used to mean any simple HTTP API, in creating the NMOS specs we have tried to adopt "correct practice" such as statelessness, uniform interface, resource identification in requests, HATEOAS, etc. (The [Wikipedia REST page] has a good summary of these.)  But as there are no hard rules on this, and a certain amount of pragmatism has also been used, especially for more control-oriented activities such as connection management.


#### Technology independence through data modelling

This might seem to conflict with some of the above, but it doesn't have to. In creating the NMOS specifications we have started with (UML) data models, which you will see in the NMOS repositories. The HTTP/WebSockets/RAML/JSON

 and then mapped these to JSON/HTTP/WebSockets/whatever. But should the wider IT/IP world migrate to new technologies, alternative mappings of the data models could feature in updated spec

You can see this explicitly in the relation between the logical content model and the RTP mapping specification. The IS-04 and IS-05 specifications you see on GitHub  

#### Build on widely used and open foundations

The success of HTTP and WebSockets is in part due to their open nature, being made available through IETF RFCs. The same applies to RTP, which is the basis of much industry activity on live IP at present.



#### Openly available specifications

We are using GitHub repositories to publish the specifications. These are made public as soon as is sensible, and of couse are available at no cost (AMWA is using a "RAND-Z" model for this work).  We use the Apache 2.0 open source licence for specifications (and )


#### Self-documenting specifications

Much of the "normative" part of the NMOS specifications takes the form of RAML and JSON Schema (with text-based supporting information). This allows


#### Scalable

The Internet/Web has scaled well so far (shortage of remaining public IPv4 addresses notwithstanding). NMOS APIs are built from Internet/Web technologies, so should also scale. That's the theory – at the time of writing this we are planning some practical work to study/prove this is the case, including documenting best practice.



#### Securable

Huge amounts of resources are spent on ensuring the world can use the Internet/Web securely.  NMOS APIs are built from Internet/Web technologies, so should benefit.  Again, that's the theory – so far Incubator workshops have used plain HTTP/WebSockets for expediency, but the specifications support HTTPS/WSS.  At the time of writing this we are planning some practical work to study/prove this is the case, including documenting best practice (such as what authentication, authorisation and audit technologies are well suited to networked media applications).



#### Suitable for all types of platform

Professional media has to work in many different types of environment, requiring a range of types of equipment. This means that NMOS specifications have been designed to work on many types of platform, such as:
- low-power devices, used on location and connected on a local network
- rack-mounted equipment within a fixed facility in a television centre
- virtualised in an on-premesis data centre
- on a shared or public cloud


#### Universal Identity

In NMOS specifications, everything is treated as a resource that can be uniquely identified. This is discussed in depth in the "Identity Framework" section of the [JT-NM RA]. In practice it means that every resource has a UUID/GUID that can be generated locally (rather than being assigned by a central authority). This UUID is then used within JSON messages and as part of RESTful URIs.

#### Flexible content

NMOS's content model reflects the richness of use of content in modern productions. Video, audio and data are treated as separate elements with their own identity and timing information. This allows them to be handled as required during production and rendered for consumption as needed for the platform(s).

#### Use rather than invent

NMOS specifications apply techniques used more generally for the professional media industry. Where possible we use protocols, representations, technologies, etc. that have proved successful elsewhere.

#### Benefit from modern tooling

Similarly the NMOS specifications have been written with the intent that they will be implemented using technologies that are widely known by developers with experience of network and web development.

#### Guided by JT-NM RA

This has already been mentioned, but it underpins how work on future NMOS specifications is likely to develop, as it ensures the work stays relevant across a broad community.

## NMOS Model and Glossary

Before explaining the NMOS specifications themselves it is helpful to present the model we are using in a sequence of pictures. This will also introduce some of the terminology used in NMOS specifications – this is similar to that used in the [JT-NM RA]. Be warned that in some cases common words (such as "Device") are used to represent "logical" things and so may not mean what you expect.  A more complete list of NMOS terminology is provided in the [Glossary].

In NMOS specifications a **Device** represents a _logical_ block of functionality, and a **Node** is the host for one or more Devices.

![Node-Devices](images/node-devices.png)

Devices have _logical_ inputs and outputs called **Receivers** and **Senders**, for example:

![Node-Device-Sender](images/node-device-sender.png)

or:

![Node-Device-Receiver](images/node-device-receiver.png)

or:

![Node-Device-Senders-Receivers](images/node-device-senders-receivers.png)


Devices, Senders and Receivers are all **Resources**. A Resource is a uniquely identified and addressable part of a networksed system:

![Node-Device-Sender-Receiver-UUIDs](images/node-device-sender-receiver-uuids.png)  

As an example, consider an IP-enabled camera. Associated with it there will probably be a Node, a Device, A video Sender, an audio Sender (if it has microphones), and maybe a data Sender (e.g. for position data), and perhaps Receivers for reverse video, intercom and control data.


NMOS uses the term **Flow** for a sequence of video, audio, or time-related data, which can _flow_ from a Sender to a Receiver or Receivers. A Flow is treated as a resource and has a unique ID:

![Node-Device-Sender-Receiver-Flow](images/node-device-sender-receiver-flow.png)  

The elements within the Flow are called **Grains**. An example of a Grain is a video frame.  Grains are associated with a position on a timeline:

![Grains-Flow](images/grains-flow.png)

Although Grains often are regularly spaced, they don't have to be, for example in the case of Data Grains representing irregular events:

![Grains-Irregular](images/grains-irregular.png)


Each Flow is also associated with a **Source**. This is the _logical_ originator of the Flow:

![Grains-Flow-Source](images/grains-flow-source.png)

So in the NMOS model, a camera could be have several associated resources:
- Node
- Device
- Video, Audio and Data Sources
- Video, Audio and Data Senders
- Video, Audio and Data Receivers (for tally, viewfinder and comms)
- Video, Audio and Data Flows


So far, NMOS specifications have worked with quite fine-grained Resources (pun unavoidable).  Future NMOS specifications will consider functionality and content at a higher level, for example for detailing with "bundles" of Flows.


## The Specifications

This section outlines the publicly available NMOS specifications

### Discovery and Registration Proposed Specification (IS-04)

https://github.com/AMWA-TV/nmos-discovery-registration

This Specification enables applications to discover networked resources, which is an important first step towards automation and scalability.

It specifies:

- an HTTP **Registration API** that Nodes use to register their resources with a **Registry**.
- an HTTP **Query API** that applications use to find a list of available resources of a particular type (Device, Sender, Receiver...) in the Registry.
- an HTTP **Node API** that applications use to find further resources on the Node.
- how to announce the APIs using DNS-SD, so the API endpoints don't have to be known by Nodes or Applications.
- how to achieve "peer-to-peer" discovery using DNS-SD and the Node API, where no Registry is available.

It also includes a basic connection management mechanism that was used before the creation of IS-05 (see below). This is deprecated, and will be removed in later versions of IS-04.


### Device Connection Management WIP Specification (future IS-05)

https://github.com/AMWA-TV/nmos-device-connection-management

This Specification provides an HTTP API for establishing (and removing) Flows between Senders and Receivers.

This allows the connection to made in a way that doesn't require knowledge of the transport protocol that will be used. It can be used for both unicast and multicast connections, and to initiate a connection made by a separate controller application.

It allows connections to be prepared and "activated" at a particular time and allows multiple connections to be made/unmade at the same time (sometimes known as "bulk" or "salvo" operation).


### Network Control WIP Specification (future IS-06)
https://github.com/AMWA-TV/nmos-network-control

This Specification can be considered as a "northbound API" for SDN controllers. It allows ...




### Content Model WIP Specification

https://github.com/AMWA-TV/nmos-content-model

- Presents a logical model for content including Grains, Flows, Sources and their relation to time.

### In-stream Signaling of Identity and Timing information for RTP streams WIP Specification

https://github.com/AMWA-TV/nmos-in-stream-id-timing

- Specifies how Grains relate to RTP and how to use RTP header extensions to include identity and timing information.


## NMOS Data Model Overview

NMOS uses a logical data model based on the [JT-NM Reference Architecture](http://www.jt-nm.org/RA-1.0/) to add identity, relationships and time-based information to content and broadcast equipment. Hierarchical relationships group related entities, with each entity having its own UUID (ID and UUID are used interchangeably in this document).

The traditional assumption of *"different connectors for different signals"* is replaced by the use of logical interfaces on common network interfaces, exposing video, audio and data inputs and outputs, and control parameters. This makes communication easier and helps with virtualization of broadcast equipment, with multiple devices operating on a shared physical host.

Data modeling -- identifying the important parts of a system and the relationships between them -- has an essential role to play in specifying what goes over the logical interfaces and will be an essential part of the transition of broadcasting and media production infrastructure to make the most of IP.

![Data Model](images/data-model.png)

### Node

**Nodes** are logical hosts for processing and network operations. They may have a permanent physical presence, or may be created on demand, for example as a virtual machine in a cluster or cloud. Connections between Nodes through which content is transported are created to build a functioning broadcast plant.

### Devices

Nodes provide **Devices**, which are logical groupings of functionality (such as processing capability, network inputs and outputs).

### Sources, Flows and Grains

Devices with the capability to originate content must provide an abstract logical point of origin for this, called a **Source**. A Device may have multiple Sources.

Sources are the origin of one or more **Flows**, which are concrete representations of content.

Flows are composed of sequences of **Grains**. A Grain represents an element of Essence or other data associated with a specific time, such as a frame, a group of consecutive audio samples, or captions.

Grains also contain metadata information that specifies attributes such as the temporal duration of the payload, useful timestamps, originating Source ID and the Flow ID the grain is associated with.

As an example, consider the above concepts in the context of a video camera with an on-board microphone:

-   The camera itself is a Node, which provides a single Device with two Sources (one audio Source, one video Source).

-   The audio Source provides a single audio Flow.

-   The video Source provides (for the purposes of this example) two video Flows, one uncompressed, the other mezzanine encoded.

Sources, Flows and Grains are formalized in the [NMOS Content Model](https://github.com/AMWA-TV/nmos-content-model).

### Senders and Receivers

Devices transmit and receive Flows over the network using **Senders** and **Receivers.** These can be respectively considered as "virtual output ports" and "virtual input ports" on the Device. Receivers connect to Senders in order to transport content.

## Accessing a Node's resources

Each Node represents the resources in its data model using a RESTful HTTP/JSON API called the **Node API**, which forms part of the Discovery and Registration Specification, and may also be used by future NMOS specifications.


## Timing

The [NMOS Content Model](https://github.com/AMWA-TV/nmos-content-model) has been designed around the assumption that Nodes have access to a globally synchronized Clock to synchronize their Devices.

In typical usage (including the workshops of the AMWA Networked Media Incubator) the Clock is derived from GPS-locked PTP (using an epoch of 1970-01-01T00:00:00TAI) and is used to govern the capture of essence such as video frames, providing frame synchronization between discrete Devices.

Each Grain is timestamped using the Clock in order to provide the means for synchronization of Flows where required, and unique identity for Grains in time. Two timestamps are used for each Grain:

-   **Origin Timestamps** provide the original sampling instant of the media at the edge of the system, uniquely referenceable for all time.

-   **Synchronization Timestamps** provide a means to cross-reference between Flows which may have passed through the network fabric via different paths, or passed through processing chains (such as codecs) which impose different levels of delay.

By pairing these timestamps with Flow identifiers, it is possible to track a video frame or other essence through its chain of ancestors right back to the Device which originally captured it and the instant in time when that occurred.


## Example System Architecture

This section describes the overarching structure of a broadcast plant using NMOS data model and APIs. It explores how Nodes communicate, and how a multi-Node system is created.

### Node Structure

Regardless of their implementation, viewed logically, Nodes provide:

-   An HTTP API to allow clients to view and manipulate the Node data model.

-   Interfaces (in the logical sense) through which content is transported.

-   A PTP slave for timing and synchronization.

The Node HTTP API is specified within the [discovery and registration specification](https://github.com/AMWA-TV/nmos-discovery-registration).

NMOS does not specify the internal interfaces within a Node, although the following diagram may be helpful:

![Node Components](images/node-components.png)

## Registering and Discovering Nodes

The Registration and Discovery Specification describes two mechanisms for discovery of Nodes and their resources: **peer-to-peer** and **registered**. Note that these two mechanisms may co-exist if this is operationally useful.

### Peer-to-Peer Discovery

Peer-to-peer (P2P) discovery requires no additional infrastructure. Nodes make DNS Service Discovery (DNS-SD) announcements regarding the presence of their Node API. Peers browse for appropriate DNS records and then query the node HTTP API for further information.

### Registered Model

Registered discovery takes place using a **Registration & Discovery System (RDS)**, which is designed to be modular and distributed. An RDS is composed of one or more **Registry & Discovery Instances (RDIs)**. Each RDI provides:

* A **Registration Service**
* A **Query Service**
* A **Registry** storage backend.

![Registration and Discovery](images/registration-and-discovery.png)

The Registration Service implements the **Registration API** (RESTful HTTP/JSON) of the NMOS Discovery and Registration Specification.  Nodes POST to this API to register themselves and their resources. The Registration Service also manages garbage collection of Nodes and their resources by requiring Nodes to send regular keep-alive/heartbeat messages.

The Query Service implements the **Query API** (RESTful HTTP/JSON) of the NMOS Discovery and Registration Specification. Clients can GET lists of resources from this API. Typical usage examples include:

* Obtaining a list of registered Nodes in order to drive a configuration interface.
* Obtaining a list of Sender resources and a list of Receiver resources in order to provide a connection management interface.

The Query API also provides the ability to generate ‘long lived’ queries using its Subscription mechanism and WebSockets.

The Registration and Query APIs are specified within the [discovery and registration specification](https://github.com/AMWA-TV/nmos-discovery-registration).

### Examples

The diagram below shows examples of peer-to-peer and registered discovery.

![Registration Sequence](images/registration-sequence.png)

## Connection Management

**Note: this section describes a particular approach to making/removing connections between Senders and Receivers that the AMWA Networked Media Incubator has used for Connection Management for the first three workshops, and for the public demonstration of IS-04 at IBC 2016. The Incubator is developing a more general API for device connection management, which should form the basis of a future NMOS specification.**

Sender and Receiver resources enable connectivity between Nodes. Senders expose a description of what Flow they are sending and an href to access it (the ‘manifest’).

For RTP, we use **SDP** files as our ‘manifest’. Senders expose an SDP file that describes the location of the Sender’s RTP stream. _Note: other information in this SDP file is also used by the In-stream Identity and Timing Specification, which includes example SDP files._

To form a connection between two Nodes, a connection manager PUTs some structured data about a Sender (including a reference to the manifest href) to a Receiver. The Receiver parses the manifest and begins accessing the stream.

Each time a Receiver changes the Sender it is receiving from, the Node resource describing the Receiver must be updated on the Node, and also the Node must notify the Registration & Discovery system.

The diagram below shows a typical connection management sequence.

![Connection Sequence](images/connection-sequence.png)

## Content Transport

NMOS’s content model can be applied to several types of elemental payload format and transport protocol, including, but not limited to:

* Uncompressed video over RTP according to [RFC 4175](https://tools.ietf.org/html/rfc4175)
* Uncompressed audio over RTP according to [RFC 3190](https://tools.ietf.org/html/rfc3190)
* ST.291 ANC data over RTP according to  [draft-ietf-payload-rtp-ancillary-02](https://tools.ietf.org/html/draft-ietf-payload-rtp-ancillary-02)

The above are used by VSF's TR-03 and are being standardized by SMPTE in the ST 2110 family of specifications.

In addition **multiplexed** streams are supported, in particular:
* SMPTE ST 2022-6 (SDI over RTP)

NMOS APIs include a "format" attribute to describe they type of Sources and Flows. _Note: for successful operation with multiplexed streams, v1.1 or later of IS-04 is required._

[NMOS In-stream Signaling of Identity and Timing information for RTP streams](https://github.com/AMWA-TV/nmos-in-stream-id-timing) specifies how to apply the content model using **RTP header extensions** to carry identity and timing information and signal Grain boundaries. These can be extended to support e.g. mezzanine compression formats such as VC-2.

Future NMOS specifications may be produced to specify how to apply the content model to other types of content transport (e.g. HTTP-based).


[comment]: <> (References/Links)

[AES-67]: http://www.aes.org/publications/standards/search.cfm?docID=96 "AES67-2015: AES standard for audio applications of networks - High-performance streaming audio-over-IP interoperability"

[AMWA]: http://amwa.tv "Advanced Media Workflow Association"

[JT-NM RA]: http://jt-nm.org/RA-1.0/ "Joint Task Force on Networked Media (JT-NM): Reference Architecture V1.0"

[NMOS]: http://nmos.tv "Networked Media Open Specifications website"

[Serial Digital Interface]: http://ieeexplore.ieee.org/document/7292109/ "ST 259:2008 - SMPTE Standard - For Television — SDTV1 Digital Signal/Data — Serial Digital Interface"

[SMPTE Timecode]: http://ieeexplore.ieee.org/document/7291029/ "ST 12-1:2014 - SMPTE Standard - Time and Control Code"

[ST 2022-6]: http://ieeexplore.ieee.org/document/7289943/ "ST 2022-6:2012 - SMPTE Standard - Transport of High Bit Rate Media Signals over IP Networks (HBRMT)"

[ST 2110]: https://www.smpte.org/webcasts/Standards-SMPTE-ST-2110 "SMPTE ST 2110 – Professional Media over IP Networks"

[Wikipedia REST page]: https://en.wikipedia.org/wiki/Representational_state_transfer "Wikipedia REST page"
