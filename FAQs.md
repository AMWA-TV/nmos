# NMOS FAQs

## Who is AMWA?

[AMWA] is the Advanced Media Workflow Association. Originally it was known for developing application specifications for using [MXF] (for example the [AS-11] family is used for delivery of finished media assets to a broadcaster or publisher).

In recent years AMWA has widened its attention to cover the application and control layers for networked media.  Much of this is happening in the Networked Media Incubator project, and this complements other industry activity looking at wire formats and codecs.  

## What is the Networked Media Incubator?

AMWA set up the Networked Media Incubator (also called just "Incubator" here) in September 2015 "to establish open specifications for end-to-end identity, media transport, timing, discovery and registration, connection management and control."

## What are IS-04, IS-05, IS-06, etc?

These are codes assigned by AMWA for Interface Specifications they create, including the NMOS specs so far.  

Specs get an IS number once they reach Proposed status.  At the time of writing IS-04 is assigned to discovery and registration but IS-05 and IS-06 have been reserved for connection management and network control respectively.

It is possible that future NMOS specs may not start with "IS".  For example "AS" is used for Application Specifications and "MS" for Data Model Specifications.  Also "BCP" is used for Best Current Practice.

For more detail on AMWA's specifcation process see [BCP-001].


## Where can I find the NMOS specifications?

If you are viewing this FAQ on GitHub you already know the answer, but in case you are reading a copy, then you will find them at https://github.com/AMWA-TV/.  The NMOS specifications are in repositories starting "nmos", for example https://github.com/AMWA-TV/nmos-discovery-registration is the IS-04 specification.

Note that some specifications are in private repos in their early stages.  These are accessible to Incubator members (if you are a member who needs access, please contact the Incubator or activity lead).

## Where can I find an implementation?

Several members of the AMWA Networked Media Incubator have created IS-04 implementations, some of which are open source:

* [BBC's implementation], used as a reference by during Incubator workshops (Python).
* [Ledger], part of Streampunk's suite for networked media (NodeJS).

The reference implementation for IS-05 connection management is expected to be made open source soon.

## What is a Source, Flow, Grain, Node, Device, Sender, Receiver...?

NMOS uses these common terms (capitalised) in specific ways that may not always correspond to your expectation.  They are defined in the specifications and summarised in the [Glossary].

## How does IS-04 scale?

IS-04 covers the APIs used for discovery and registration, and how to find the API Endpoints, but does not define an implementation of a registry. This allows implementors and integrators to choose an  approach to scalability that is appropriate to topology of the infrastructure and how it is used.

[BBC's implementation] currently scales by using a registry based on [etcd], an open source distributed key-value store that allows a cluster of instances to be provisioned on a single or multiple networks.  The details of how etcd instances federate their information is not part of IS-04.

 _(NB the BBC would like to point out that other distributed key-value stores are available, and its implementation could be easily modified to use them_).


## How can NMOS be used securely?

NMOS APIs have supported use of HTTPS and WSS (secure WebSockets) since IS-04 v1.1. So far these haven't been used at Incubator workshops, but this is something we expect to happen in the future. As part of this we are likely to investigate and agree a suitable set of technologies to enable AAA (authentication, authorisation and audit) when using NMOS, where possible taking input from the AMWA Labs work.

## Does NMOS require multicast?

**No.** This is an FPM (Frequently Propagated Misunderstanding).

IS-04 specifies how NMOS API Endpoints can be found using DNS-SD. This can use either unicast or multicast DNS (and BBC R&D uses both, according to the requirements of its work).

Furthermore IS-04's use of DNS-SD is quite minimal – used to "bootstrap" operations.  The main part of IS-04 is based on HTTP and WebSockets, and is _independent of how the Endpoints are discovered_.


(BTW, IS-04 peer-to-peer mode also will work with unicast DNS, although this would be an unusual case. A more likely case is that two devices are connected peer-to-peer via a low-cost switch that treat multicast packets as broadcast – this will still work.)

The Flows that are discovered and connected through NMOS can be multicast (this has usually been the case for Incubator workshops) but can be unicast, and the connection management API supports both multicast and unicast models. See also question below about RTP.

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

**Great question!**  At the time of writing, the AMWA board has just voted to proceed with elevation of IS-04 v1.0 and v1.1 to full AMWA Specification (It's quite likely that by the time you read this the spec will have been updated to reflect this.)

However, there will be further versions of IS-04 and other NMOS specs. v1.2 (currently work in progress as of August 2017) includes support for IS-05 connection management and deprecates the v1.0/v1.1 connection management mechanism.  Later versions may support further functionality and refactoring of NMOS – as the professional networked media industry matures we can expect requirements to keep changing, so although individual versions will be "done", NMOS will not stand still.

As for formal due-process standardisation of particular versions of NMOS specifications, this is a question for SMPTE and the desire or otherwise of the industry to see this happen.

## Why does IS-04 have connection management if there is IS-05?

**History.** IS-04 v1.0 and v1.1 predate IS-05. A basic connection management mechanism was needed at earlier Incubator workshops so that we could connect together senders and receivers. This was included in IS-04 as an expediency, but doesn't really belong there.  Recent workshops use the separate, and more flexible device connection management API.  Once IS-05 becomes a Proposed Specifcation, the IS-04 mechanism will be deprecated in v1.2 and may be removed in later versions.

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

[comment]: <> (References/Links)

[AMWA]: http://amwa.tv "Advanced Media Workflow Association"

[Arachnid]: https://github.com/Streampunk/arachnid "Streampunk Arachnid"

[AS-11]: http://www.amwa.tv/projects/AS-11.shtml "AMWA AS-11"

[BBC IP Studio]: http://www.bbc.co.uk/rd/projects/ip-studio "BBC R&D IP Studio"

[BBC's implementation]: https://github.com/bbc/nmos-discovery-registration-ri "IS-04 reference implementation"

[BCP-001]: http://amwa.tv/projects/BCP-001.shtml "BCP-001: AMWA Specification Process"

[Glossary]: Glossary.md "Glossary"

[Incubator rules]: http://www.amwa.tv/projects/nmi/AMWA_NMOS_Rules_v2.11.pdf "AMWA Networked Media Incubator rules"

[IPR Policy]: http://www.amwa.tv/about/policies/AMWA_IPR_Policy_V3.0.pdf "AMWA IPR Policy"

[JT-NM]: http://jt-nm.org "Joint Task Force on Networked Media (JT-NM)"

[Ledger]: https://github.com/Streampunk/ledger "Streampunk Ledger"

[MXF]: http://tech.ebu.ch/docs/techreview/trev_2010-Q3_MXF-2.pdf "MXF - a technical review"

[Networked Media Incubator]: http://nmos.tv/about_NMI.html "Networked Media Incubator"

[In-stream Signaling Specification]: https://github.com/AMWA-TV/nmos-in-stream-id-timing "AMWA WIP Specification: In-stream Signaling of Identity and Timing information for RTP streams"

[Technical Overview]: NMOS%20Technical%20Overview.md "NMOS Technical Overview"
