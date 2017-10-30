# NMOS Technical Overview

_(c) AMWA 2017, CC Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)_

For the latest version of this document please go to https://github.com/AMWA-TV/nmos.

## Introduction

Networked Media Open Specifications ([NMOS]) are a family of specifications that support the professional AV media industry's transition to a "fully-networked" architecture. The NMOS specs are developed by the Advanced Media Workflow Association ([AMWA]) and are published on GitHub.

### Background

While much of the broadcast industry has moved to file-based operation, live facilities have long depended on specialist technologies such as the [Serial Digital Interface] (SDI), [SMPTE Timecode] and various incompatible control protocols (including some using RS-232, some of which are still in use).  However (as of 2017) there is a significant move towards replacing these with more general IT/IP technologies, allowing the industry to benefit from the high speeds and economies of scale that have enabled the success of the Internet and Web.

Specifications such as [ST 2022-6], [ST 2110] and [AES-67] define specific

, in its Networked Media Incubator group. This brings system developers together to develop, test and document practical solutions for

In 2013 the Joint Task Force on Networked Media ([JT-NM]) to coordinate work across industry groups on interoperability. One of the outputs of the task force has been a Reference Architecture, which provides a collection of models, best practices, and frameworks.  This included a number of 

## General Principles

NMOS specifications make use A number of common

### Web-friendly protocols

* HTTP
* WebSockets

### Build on

* IETF RFCs

### Open ...

### REST

### Self-documenting specifications

Such as RAML


### Sec

### Universal Identity

* Everything can be identified
* UUID/GUID


- Learn from how the Internet and Web have grown
- Identity is important
- It’s not just about video and audio
- Open approach
- Use rather than invent
- Benefit from modern tooling
- Independent of infrastructure
- Guided by JT-NM RA




and are made available through AMWA GitHub repos.

Currently the publicly available specifications and links to repos are as follows:

* [Discovery and Registration Proposed Specification (IS-04)](https://github.com/AMWA-TV/nmos-discovery-registration)
* [Content Model WIP Specification](https://github.com/AMWA-TV/nmos-content-model)
* [In-stream Signaling of Identity and Timing information for RTP streams WIP Specification](https://github.com/AMWA-TV/nmos-in-stream-id-timing)
* [Device Connection Management WIP Specification](https://github.com/AMWA-TV/nmos-device-connection-management)
* [Network Control WIP Specification](https://github.com/AMWA-TV/nmos-network-control)


This document provides a high-level technical overview of the NMOS data model and specifications, including examples of how these may be used.




## Data Model Overview

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

[NMOS]: http://nmos.tv "Networked Media Open Specifications website"

[AMWA]: http://amwa.tv "Advanced Media Workflow Association"

[JT-NM]: http://jt-nm.org "Joint Task Force on Networked Media (JT-NM)"

[Serial Digital Interface]: http://ieeexplore.ieee.org/document/7292109/ "ST 259:2008 - SMPTE Standard - For Television — SDTV1 Digital Signal/Data — Serial Digital Interface"

[SMPTE Timecode]: http://ieeexplore.ieee.org/document/7291029/ "ST 12-1:2014 - SMPTE Standard - Time and Control Code"

[ST 2022-6]:

[ST 2110]:

[AES-67]:
