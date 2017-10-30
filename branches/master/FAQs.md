# NMOS FAQs

_(c) AMWA 2017, CC Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)_

[//]: # (ToC goes after this comment. Create it with "gh-md-toc")

* [Who is AMWA?](#who-is-amwa)
* [What is the Networked Media Incubator?](#what-is-the-networked-media-incubator)
* [What are IS\-04, IS\-05, IS\-06, etc?](#what-are-is-04-is-05-is-06-etc)
* [Where can I find the NMOS specifications?](#where-can-i-find-the-nmos-specifications)
* [Where can I find an implementation?](#where-can-i-find-an-implementation)
* [What is a Source, Flow, Grain, Node, Device, Sender, Receiver\.\.\.?](#what-is-a-source-flow-grain-node-device-sender-receiver)
* [How does IS\-04 scale?](#how-does-is-04-scale)
* [How can NMOS be used securely?](#how-can-nmos-be-used-securely)
* [Does NMOS require multicast?](#does-nmos-require-multicast)
* [Does NMOS require RTP?](#does-nmos-require-rtp)
* [Does NMOS work in the cloud?](#does-nmos-work-in-the-cloud)
* [Why does NMOS deal with only individual elemental Flows?](#why-does-nmos-deal-with-only-individual-elemental-flows)
* [Why does NMOS deal with only uncompressed Flows?](#why-does-nmos-deal-with-only-uncompressed-flows)
* [How does my company / project show its USPs?](#how-does-my-company--project-show-its-usps)
* [If the “O” in NMOS means “open”, why are Incubator workshops closed?](#if-the-o-in-nmos-means-open-why-are-incubator-workshops-closed)
* [What is "NMOS compliant/certified"?](#what-is-nmos-compliantcertified)
* [Can I be sure that I won't be subject to patent fees/litigation if I implement NMOS?](#can-i-be-sure-that-i-wont-be-subject-to-patent-feeslitigation-if-i-implement-nmos)
* [When will IS\-04 / NMOS be standardised? When is it “done”?](#when-will-is-04--nmos-be-standardised-when-is-it-done)
* [Why does IS\-04 have connection management if there is IS\-05?](#why-does-is-04-have-connection-management-if-there-is-is-05)
* [Why does IS\-05 use SDP? And why not <em>just</em> use SDP?](#why-does-is-05-use-sdp-and-why-not-just-use-sdp)
* [What is the relationship between connection management and network control?](#what-is-the-relationship-between-connection-management-and-network-control)
* [What is the relationship between NMOS and AMWA Labs?](#what-is-the-relationship-between-nmos-and-amwa-labs)
* [Can I use IS\-xx without having to use IS\-yy?](#can-i-use-is-xx-without-having-to-use-is-yy)
* [How do NMOS specifications fit into the wider community activity on interoperability?](#how-do-nmos-specifications-fit-into-the-wider-community-activity-on-interoperability)


[//]: # (ToC goes before this comment)

## Who is AMWA?

[AMWA] is the Advanced Media Workflow Association. Originally it was known for developing application specifications for using [MXF] (for example the [AS-11] family is used for delivery of finished media assets to a broadcaster or publisher).

In recent years AMWA has widened its attention to cover the application and control layers for networked media.  Much of this is happening in the Networked Media Incubator project, and this complements other industry activity looking at wire formats and codecs.  

## What is the Networked Media Incubator?

AMWA set up the Networked Media Incubator (also called just "Incubator" here) in September 2015 "to establish open specifications for end-to-end identity, media transport, timing, discovery and registration, connection management and control."

## What are IS-04, IS-05, IS-06, etc?

These are identifiers assigned by AMWA for Interface Specifications they create, including the NMOS specs so far.  

Specs get an IS number once they reach Proposed status.  At the time of writing IS-04 is assigned to discovery and registration but IS-05 and IS-06 have been reserved for connection management and network control respectively.

It is possible that future NMOS specs may not start with "IS".  For example "AS" is used for Application Specifications and "MS" for Data Model Specifications.  Also "BCP" is used for Best Current Practice.

For more detail on AMWA's specification process see [BCP-001].


## Where can I find the NMOS specifications?

If you are viewing this FAQ on GitHub you already know the answer, but in case you are reading a copy, then you will find them at https://github.com/AMWA-TV/.  The NMOS specifications are in repositories starting "nmos", for example https://github.com/AMWA-TV/nmos-discovery-registration is the IS-04 specification.

Note that some specifications are in private repos in their early stages.  These are accessible to Incubator members (if you are a member who needs access, please contact the Incubator or activity lead).

## Where can I find an implementation?

As well as proprietary implementations, several open-source implementations IS-04 and IS-05 are available.  See the page on [Implementations] for up-to-date information. At the time of writing this, they all use the Apache 2.0 license, which matches the NMOS specifications themselves.

If you have an open-source implementation you would like added, please send a pull request to this repository.


## What is a Source, Flow, Grain, Node, Device, Sender, Receiver...?

NMOS uses these common terms (capitalised) in specific ways that may not always correspond to your expectation.  They are defined in the specifications, explained in the [Technical Overview] and summarised in the [Glossary].

## How does IS-04 scale?

IS-04 covers the APIs used for discovery and registration, and how to find the API Endpoints, but does not define an implementation of a registry. This allows implementors and integrators to choose an  approach to scalability that is appropriate to topology of the infrastructure and how it is used.

[BBC's IS-04 implementation] currently scales by using a registry based on [etcd], an open source distributed key-value store that allows a cluster of instances to be provisioned on a single or multiple networks.  The details of how etcd instances federate their information is not part of IS-04.

 _(NB the BBC would like to point out that other distributed key-value stores are available, and its implementation could be easily modified to use them_).

As of late September 2017, a new activity has just started in the Incubator to test the performance of IS-04 at scale.

## How can NMOS be used securely?

NMOS APIs have supported use of HTTPS and WSS (secure WebSockets) since IS-04 v1.1. So far these haven't been used at Incubator workshops, but this is something we expect to happen in the reasonably near future (I'm writing this in late September 2017).

As part of this we are likely to investigate and agree a suitable set of technologies to enable AAA (authentication, authorisation and audit) when using NMOS, where possible taking input from the AMWA Labs work.

## Does NMOS require multicast?

**No.** This is an FPM (Frequently Propagated Misunderstanding).

IS-04 specifies how NMOS API Endpoints can be found using DNS-SD. This can use either unicast or multicast DNS (and BBC R&D uses both, according to the requirements of its work).

Furthermore IS-04's use of DNS-SD is quite minimal – used to "bootstrap" operations.  The main part of IS-04 is based on HTTP and WebSockets, and is _independent of how the Endpoints are discovered_.

(BTW, IS-04 peer-to-peer mode also will work with unicast DNS, although this would be an unusual case. A more likely case is that two devices are connected peer-to-peer via a low-cost switch that treat multicast packets as broadcast – this will still work.)

The Flows that are discovered and connected through NMOS can be multicast (this has usually been the case for Incubator workshops) but can be unicast, and the connection management API supports both multicast and unicast models. See also question below about RTP.

Generally we have been using multicast and IGMP at the Incubator workshops to date, both for DNS-SD and for media streams. That reflects the focus on 2110-type use cases. Where we need to address different cases, future workshops could take a different approach. See also the question about "the cloud" below.

## Does NMOS require RTP?

**No.** The transport used for Flows is independent of how the Flows are discovered and how connections are made. Incubator workshops have mostly used RTP (see also the [In-stream Signaling Specification]), which corresponds to the industry's current attention on ST 2022-6 and ST 2110, but NMOS can be used with HTTP and other transport protocols. Streampunk's [Arachnid] is an example of how Grains may be transported over HTTP(S), using HTTP headers to carry identity, timestamp and other Grain attributes.

## Does NMOS work in the cloud?

**Yes.** The [BBC IP Studio] team has been addressing how its live IP technology – which uses NMOS – can be deployed on a range of platforms, including in-house and public cloud.

## Why does NMOS deal with only individual elemental Flows?

**It doesn't have to.** Since v1.1, IS-04 has supported multiplexed Flows. In particular, it has been used with ST 2022-6 (SDI over RTP).

Also a future "grouping" specification may allow applications to deal with multiple individual Flows together.

## Why does NMOS deal with only uncompressed Flows?

Again, **it doesn't have to.** See question about RTP above.


## How does my company / project show its USPs?

SDI has allowed users to choose between vendors based on the functionality, features and performance of their devices (amongst other factors), and be sure that they will interoperate correctly, rather than have to think about "box X will work with box Y but not box Z".

It's similar with NMOS – but better because users will be able to use software and virtualised devices, not just hardware ones. NMOS addresses "foundational" building blocks such as identity, discovery and connection that enable interoperability between networked devices.  

But NMOS doesn't (and won't) attempt to "standardise" the functions, features, or performance of the networked devices. It will however provide a framework that manufactures can link to their specific information. For example hierarchical URIs allow allow manufacturer-specific elements to be included in JSON API messages.

## If the “O” in NMOS means “open”, why are Incubator workshops closed?

The Incubator, and its workshops, have been set up to provide an environment to encourage cooperation between members, and allow them to work together, online and at workshops towards interoperability in a low-risk way. This means that they don't have to worry about their fellow participants – who also may be their competitors – reporting negatively about their implementation, as this is forbidden by the [Incubator rules].

In addition, there are costs associated with running AMWA and the Incubator that are met at least in part through membership fees. Companies need to be an Associate or higher member to participate, and a nominal cost Indvidual membership is also available.

Of course the NMOS specifications themselves are made publicly available (Apache 2 licence) as early as is practical, and at latest on elevation to Proposed AMWA Specification.

## What is "NMOS compliant/certified"?

**These are not defined at this time**. We work through interoperability checklists at workshops and in preparation for public demonstrations but this is is for internal use only, and does not let vendors claim compliance.

In addition, AMWA does not currently provide a certification process for NMOS implementations. Of course this may change in the future.

## Can I be sure that I won't be subject to patent fees/litigation if I implement NMOS?

AMWA's [IPR Policy] attempts to minimise such a risk by requiring participants to disclose any knowledge of possibly relevant patents and requiring all AMWA Specifications to have an IPR review.

In addition, NMOS/Incubator is "RAND-Z" so it requires any contributions to be made available on a reasonable and non-discriminatory basis at zero cost.

And the NMOS APIs are built on widely adopted patterns used on the Internet/Web, using open-source components wherever available.

## When will IS-04 / NMOS be standardised? When is it “done”?

**Great question!**  At the time of writing, IS-04 v1.0 and v1.1 have been recently elevated to full AMWA Specification.

However, there will be further versions of IS-04 and other NMOS specs. v1.2 (expected to be elevated to Proposed Specifcation in October 2017) includes support for IS-05 connection management and deprecates the v1.0/v1.1 connection management mechanism.  

Later versions may support further functionality and refactoring of NMOS – as the professional networked media industry matures we can expect requirements to keep changing, so although individual versions will be "done", NMOS will not stand still.

As for formal due-process standardisation of particular versions of NMOS specifications, this is a question for SMPTE and the desire or otherwise of the industry to see this happen.

## Why does IS-04 have connection management if there is IS-05?

**History.** IS-04 v1.0 and v1.1 predate IS-05. A basic connection management mechanism was needed at earlier Incubator workshops so that we could connect together senders and receivers. This was included in IS-04 as an expediency, but doesn't really belong there.  Recent workshops use the separate, and more flexible device connection management API.  Once IS-05 becomes a Proposed Specifcation, the IS-04 mechanism will be deprecated in v1.2 and may be removed in later versions.

## Why does IS-05 use SDP? And why not _just_ use SDP?

Despite its ugliness, as of 2017 [SDP] is still regularly used with RTP media streams, and is included in SMPTE's ST 2110-10 for describing streams. So 2110-compliant senders and receivers will be using it anyway, and it makes sense for IS-05 to use it. This can be either within the JSON messages or via a link.

However, IS-05 doesn't _require_ the use of SDP. It abstracts it through the Sender's ``/transportfile`` resource, and alternative formats can be used. For a non-RTP transport this will certainly be the case (e.g. DASH manifest).  

And relying on _just_ SDP itself isn't enough. It describes the streams but doesn't provide a means of making connections, so we would be reliant on proprietary mechanisms.


## What is the relationship between connection management and network control?

The NMOS Network Control API (future IS-06) is concerned with what happens within the network itself. It deals with lower-level concepts than IS-04 and IS-05, i.e. network endpoints on NICs and switches, and control of the individual "network flows" between these.

The NMOS Connection Management API (future IS-05) is concerned with creation of higher-level _logical_ connections between the Senders and Receivers of Devices. Although it's quite possible that an IS-05 connection/disconnection request may cause a controller to invoke IS-06 to "make it happen", this doesn't have to be the case.  

## What is the relationship between NMOS and AMWA Labs?

[AMWA Labs] is about learning how a "cloud-first" approach to networked media might work – the group so far has looked at performance using HTTP-based transport, compression and encryption. The Labs group doesn't create specifications, but its output in part shows what can be possible, and in part informs what will be needed for a future "NMOS toolbox", which  will help in determining next work in the Incubator.

## Can I use IS-xx without having to use IS-yy?

**No, but...** It's possible to use the NMOS specifications independently, but they benefit from being used in combination. For example, the Connection Management API (future IS-05) will allow connections  between manually configured IP addresses (perhaps entered into a spreadsheet?), but this becomes unmanageable in large and changing environments, where the benefits of automated discovery using IS-04 become overwhelming.

## How do NMOS specifications fit into the wider community activity on interoperability?

The **Joint Task Force on Networked Media** is a an industry group that was set up a few years ago to coordinate work on interoperability.  AMWA and NMOS are an important part of how this is developing in practice. The IS-xx specifications appear on the JT-NM industry roadmap and have featured at demonstrations at IBC and NAB.

This is discussed further in the [Technical Overview].

[//]: # (References/Links)

[AMWA]: http://amwa.tv "Advanced Media Workflow Association"

[AMWA Labs]: https://amwa.tv/downloads/brochures/AMWA_Labs_Apr_2017.pdf "AMWA Labs update for NAB 2017"

[Arachnid]: https://github.com/Streampunk/arachnid "Streampunk Arachnid"

[AS-11]: http://www.amwa.tv/projects/AS-11.shtml "AMWA AS-11"

[BBC IP Studio]: http://www.bbc.co.uk/rd/projects/ip-studio "BBC R&D IP Studio"

[BBC's IS-04 implementation]: https://github.com/bbc/nmos-discovery-registration-ri "IS-04 reference implementation"

[BCP-001]: http://amwa.tv/projects/BCP-001.shtml "BCP-001: AMWA Specification Process"

[etcd]: https://github.com/coreos/etcd "etcd: Distributed reliable key-value store for the most critical data of a distributed system"

[Glossary]: Glossary.md "Glossary"

[Implementations]: Implementations.md "Implementations"

[Incubator rules]: http://www.amwa.tv/projects/nmi/AMWA_NMOS_Rules_v2.11.pdf "AMWA Networked Media Incubator rules"

[IPR Policy]: http://www.amwa.tv/about/policies/AMWA_IPR_Policy_V3.0.pdf "AMWA IPR Policy"

[JT-NM]: http://jt-nm.org "Joint Task Force on Networked Media (JT-NM)"

[Ledger]: https://github.com/Streampunk/ledger "Streampunk Ledger"

[MXF]: http://tech.ebu.ch/docs/techreview/trev_2010-Q3_MXF-2.pdf "MXF - a technical review"

[Networked Media Incubator]: http://nmos.tv/about_NMI.html "Networked Media Incubator"

[In-stream Signaling Specification]: https://github.com/AMWA-TV/nmos-in-stream-id-timing "AMWA WIP Specification: In-stream Signaling of Identity and Timing information for RTP streams"

[SDP]: https://tools.ietf.org/html/rfc4566 "SDP: Session Description Protocol"

[Technical Overview]: NMOS%20Technical%20Overview.md "NMOS Technical Overview"
