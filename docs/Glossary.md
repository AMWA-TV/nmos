# NMOS Glossary
{:.no_toc}

- A markdown unordered list which will be replaced with the ToC, excluding the "Contents header" from above
{:toc}

In NMOS, several common terms have specific meanings that it helps to be aware of. Many of these correspond to the glossary of the [JT-NM Reference Architecture][JT-NM RA].

Several of these are formally defined in NMOS specifications, for example in the [IS-04 Data Model](https://specs.amwa.tv/is-04/branches/v1.3.x/docs/Data_Model.html), but are described here for convenience.

## API

An Application Programming Interface provided over a protocol such as HTTP or WebSocket, defined in an AMWA NMOS Specification (IS-04, IS-05, IS-06, etc.).

## Client

The entity that is using an [API](#api), for example:

- a [Node](#node) using the IS-04 Registration API
- a monitoring application using the IS-04 Query API
- a connection control application using the IS-05 Connection API

The Client is distinct from the [User](#user).

## Controller

A Controller is [Client](#client) software that interacts with the NMOS [APIs](#api) to discover, connect and manage resources ([Nodes](#node), [Devices](#device), [Senders](#sender) and [Receivers](#receiver)) within a networked media system.

## Device

A Device is a logical block of functionality within a networked media infrastructure. Example of Devices could include:

- Camera
- SDI to IP adapter
- Chroma keyer
- Audio mixer

A Device can have a permanent presence on its [Node](#node) (a fixed Device, e.g., a networked camera), or it can be created on demand by its Node (a virtual Device, e.g., a software-based transcoder). Nodes can dynamically create different types of Device (a dynamic Device).

## Flow

In the IS-04 and IS-05 specifications a Flow refers to a sequence of video, audio or time-related data. This is a relatively high-level usage of the word, not to be confused with a low-level flow within the physical network (distinguished as a Network Flow in the [IS-06 Data Model](https://specs.amwa.tv/is-06/branches/v1.0.x/docs/Data_Model.html)).

A Flow is made up of [Grains](#grain).

## Grain

NMOS uses Grain as a convenient way of identifying a unit of video, audio or time-related data. This helps with mapping NMOS's logical data model onto physical Specifications. For example, a video Grain could correspond to a frame of video.

## Node

A Node is a _logical_ host for [Devices](#device). This can be physical, or virtual (and a Node can be within a "cluster" or "cloud").

In [JT-NM TR-1001-1][JT-NM TR-1001-1], the [EBU Technology Pyramid][EBU Tech Pyramid], and other industry documents, the term Media Node is often used.

## Receiver

A Receiver consumes a [Flow](#flow) transmitted on the network by a [Sender](#sender).

## Registry

A Registry, or Registration & Discovery Instance, is a [Server](#server) that provides the IS-04 Registration API for [Nodes](#node) and the IS-04 Query API for [Controllers](#controller).

## Sender

A Sender makes a [Flow](#flow) available on the network.

## Server

The entity that is providing an [API](#api), for example:

- a [Registry](#registry) implementing IS-04 Registration and Query APIs
- a [Node](#node) implementing IS-04 Node API and IS-05 Connection API

## Source

A Source represents the _logical_ origin of one or more [Flows](#flow).

Note that a Source is:

- not a [Device](#device) from which the content originates (for example there might be video, audio and perhaps data Sources _associated with_ a camera, the camera itself is not a Source).
- not about the physical origin of the Flows (for example: two Flows associated with the same Source might physically originate from different hardware in distinct geographical locations).

## User

Where specifications refer to a User, this can include both human operators who drive a [Controller](#controller) manually and automation systems that drive a [Controller](#controller) programmatically.

[EBU Tech Pyramid]: https://tech.ebu.ch/pyramid "The Technology Pyramid For Media Nodes: Minimum User Requirements to Build and Manage an IP-Based Media Facility"
[JT-NM RA]: https://www.jt-nm.org/reference-architecture "Joint Task Force on Networked Media (JT-NM): Reference Architecture V1.0"
[JT-NM TR-1001-1]: https://www.jt-nm.org/tr-1001-1 "Joint Task Force on Networked Media (JT-NM): Technical Recommendation TR-1001-1:2020 v1.1: System Environment and Device Behaviors For SMPTE ST 2110 Media Nodes in Engineered Networks"
