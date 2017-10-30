# NMOS Glossary

_Warning: this is far complete, and currently some of this text is just copied from the JT-NM RA Glossary, and would benefit from improvement._

In NMOS specs several common terms have specific meanings that you should be aware of. Many of these correspond to the glossary of the [JT-NM RA].

Several of these are formally defined in NMOS specs, but are described here for convenience.

#### Device

A Device is a logical block of functionality within a networked media infrastructure. Example of Devices could include:
- Camera
- SDI to IP adapter
- Chroma keyer
- Audio mixer

A Device may have a permanent presence on its Node (Fixed Device, e.g., a networked camera), or it may be created on demand by its Node (Virtual Device, e.g., a software-based transcoder). Nodes may dynamically create different types of Device (Dynamic Device).


#### Flow

In the IS-04 and future IS-05 specifications a Flow refers to a sequence of video, audio or time-related data. This is a relatively high-level usage of the word, and should not be confused with a low-level flow within the physical network.


#### Grain

NMOS specifications use Grain as a convenient way of identifying a unit of video, audio or time-related data. This helps with mapping NMOS's logical data model onto physical Specifications. For example a frame of video may correspond to a VideoGrain.  This is in effect what SMPTE ST 2110-20 does, although that specification does not mention "grains".  The [RTP In-stream Signaling Specification] builds upon this by describing a mechanism to identify the Grain (and its timing) using RTP header extensions.


#### Node

A Node is a _logical_ host for Devices. This can be physical, or virtual (and a Node can be within a "cluster" or "cloud").

#### Receiver

A Receiver consumes a Flow from a Sender.

#### Sender

A Sender makes a Flow available on the network

#### Source

A Source represents the _logical_ primary origin of one or more Flows.

Note that (despite its name) a Source is:
- NOT a Device from which the content originates (for example there might be video, audio and perhaps data Sources _associated with_ a camera, the camera itself is NOT a Source).
- NOT about the physical origin of the Flows (for example: two Flows associated with the same Source might physically originate from different hardware in distinct geographical locations)




[JT-NM RA]: http://jt-nm.org/RA-1.0/ "Joint Task Force on Networked Media (JT-NM): Reference Architecture V1.0"

[RTP In-stream Signaling Specification]: https://github.com/AMWA-TV/nmos-in-stream-id-timing "AMWA WIP Specification: In-stream Signaling of Identity and Timing information for RTP streams"
