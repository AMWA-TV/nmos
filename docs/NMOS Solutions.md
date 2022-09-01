# NMOS Solutions
{:.no_toc}

- A markdown unordered list which will be replaced with the ToC, excluding the "Contents header" from above
{:toc}

This page lists open source, free and commercial implementations of NMOS specifications.

This list is unlikely to be complete, and AMWA does not make any guarantees of conformance.

To have an implementation added, please submit a GitHub issue to the [NMOS repo](https://github.com/AMWA-TV/nmos), including the information required in the table. The implementation must be available, and a link to a repo, download page or product page must be provided.

# Open Source & Freeware

| Name | Language | License | Description |
| ---- | -------- | ------- | ----------- |
| **[Easy-NMOS](https://github.com/rhastie/easy-nmos)** | N/A | Apache 2.0 | **Free of charge, open-source, toolkit, created to simplify and speed up the adoption of NMOS APIs, developed by NVIDIA based on open-source NMOS software from Sony, BBC R&D and other AMWA members, with a video [Getting Started](https://www.amwa.tv/easy-nmos-videos) guide.** |
| [AMWA NMOS Testing Tool](https://github.com/AMWA-TV/nmos-testing/) | Python | Apache 2.0 | Testing of all current NMOS specifications |
| [BBC R&D NMOS Joint RI](https://github.com/bbc/nmos-joint-ri) |  Python | Apache 2.0  | IS-04 and IS-05 registry and APIs (used as reference in AMWA workshops). |
| [BBC R&D NMOS Web Router](https://github.com/bbc/nmos-web-router) | Javascript | Apache 2.0 | IS-04 and IS-05 web-based client application |
| [BBC R&D Authorisation Server](https://github.com/bbc/nmos-auth-server) | Python | Apache 2.0 | OAuth2 Authorisation Server based on AMWA NMOS BCP-003-02 / IS-10 |
| [NVIDIA NMOS Docker](https://hub.docker.com/r/rhastie/nmos-cpp) | N/A | Apache 2.0 | Docker container with Registry and Controller, IS-04, IS-05, IS-07, IS-08, IS-09, BCP-002-01, BCP-003-01 and BCP-004-01 |
| [Pebble Control Free](https://www.pebble.tv/control-free/) | N/A | Freeware | IS-04, IS-05, IS-07 connection management solution for Windows with support for BCP-002-01 and BCP-004-01 |
| [Riedel NMOS Explorer](https://myriedel.riedel.net/en/downloads/) | N/A | Freeware | IS-04 and IS-05 client application for Windows and Linux |
| [Sony nmos-cpp](https://github.com/sony/nmos-cpp) | C++ | Apache 2.0 | Cross-platform toolkit for IS-04, IS-05, IS-07, IS-08, IS-09, BCP-002-01, BCP-003-01 and BCP-004-01, and example Registry and Node applications |
| [Sony nmos-js](https://github.com/sony/nmos-js) | Javascript | Apache 2.0 | IS-04 and IS-05 web-based client application with support for BCP-002-01, BCP-003-01 and BCP-004-01 |
| [Streampunk Media Ledger](https://github.com/Streampunk/ledger) | Javascript (NodeJS)  | Apache 2.0 | IS-04 v1.0 APIs |

Note that inclusion in this list is not an endorsement by AMWA or a guarantee of conformance to the specifications.

# Commercial Hardware & Software

This section lists commercial implementations of the NMOS specifications. It includes information about which NMOS specifications, versions and features are supported, and provide links to the manufacturers' product pages. (Note to manufacturers: the linked product page must include information about NMOS support!)

Note that inclusion in this list is not an endorsement by AMWA or a guarantee of conformance to the specifications.

Many of these products have participated in the JT-NM Tested programme, with results available [here](http://jt-nm.org/jt-nm_tested/). Note that the JT-NM Tested badge does not constitute a 'pass', but is simply an indication that testing results are available to download.


## Controllers & Registries

| Company | Product | Supported Specifications | Comments |
| ------- | ------- | ------------------------ | -------- |
| BFE | [KSC CORE](https://www.bfe.tv/en/solutions-products/control-monitoring-systems/ksc-core/), <br/> [KSC SILKNET](https://bfe.tv/en/solutions-products/control-monitoring-systems/ksc-silknet/) | IS-04 v1.3 <br/> IS-05 v1.1 <br/> IS-07 v1.0  | Broadcast Controller, <br/> Broadcast SDN Controller |
| EVS | [Cerebrum](https://evs.com/en/product/cerebrum/) | IS-04 v1.2 <br/> IS-05 v1.0 | Broadcast Control, Orchestration and Monitoring Solution |
| Imagine Communications | [Magellan Control System](https://imaginecommunications.com/product/magellan-control-system/) | IS-04 v1.2 <br/> IS-05 v1.0 | Broadcast Routing Systems Controller for IP (NMOS and non-NMOS) and Legacy Systems <br/> Includes optional IS-04 Registry |
| NVIDIA <br/> (Mellanox) | [SN2000 Series](https://www.nvidia.com/en-us/networking/ethernet-switching/spectrum-sn2000/) <br/> [SN3000 Series](https://www.nvidia.com/en-us/networking/ethernet-switching/spectrum-sn3000/) <br/> [SN4000 Series](https://www.nvidia.com/en-us/networking/ethernet-switching/spectrum-sn4000/) <br/> [BlueField Family](https://www.nvidia.com/en-gb/networking/products/data-processing-unit/) <br/> with <br/> [NVIDIA NMOS Docker](https://hub.docker.com/r/rhastie/nmos-cpp) | IS-04 v1.3 <br/> IS-05 v1.1 <br/> IS-07 v1.0 <br/> IS-08 v1.0 <br/> IS-09 v1.0 | Spectrum Ethernet Switches <br/> Spectrum-2 Ethernet Switches <br/> Spectrum-3 Ethernet Switches <br/> BlueField Data Processing Units <br/> with <br/> [Containerized](https://www.nvidia.com/en-us/networking/ethernet-switching/onyx/) IS-04 Registry and Controller |
| Nevion | [VideoIPath](https://nevion.com/videoipath/) | IS-04 v1.2 <br/> IS-05 v1.0 | Broadcast Controller & IS-04 Registry |
| Ross | [Ultricore BCS](https://www.rossvideo.com/ultricore/) | IS-04 v1.3 <br/> IS-05 v1.1 | Broadcast controller & IS-04 Registry |
| Sony | [PWS-110NM1](https://pro.sony/en_GB/products/ip-live-products/pws-110nm1) | IS-04 v1.3 <br/> IS-05 v1.1 <br/> BCP-002-01 v1.0 | IP Live System Manager workstation |
| Pebble | [Pebble Control Lite](https://www.pebble.tv/solutions/pebble-control/) <br/> [Pebble Control Enterprise](https://www.pebble.tv/solutions/pebble-control/) | IS-04 v1.3 <br/> IS-05 v1.1 <br/> IS-07 v1.0 | IP Connection Management Solution |

## Media Nodes

| Company | Product | Supported Specifications | Comments |
| ------- | -------------- | ------------------------ | -------- |
| AJA | [IPR-10G2-HDMI](https://www.aja.com/products/mini-converters/ipr-10g2-hdmi) <br/> [IPR-10G2-SDI](https://www.aja.com/products/mini-converters/ipr-10g2-sdi) <br/> [IPR-10G-HDMI](https://www.aja.com/products/mini-converters/ipr-10g-hdmi) <br/> [IPT-10G2-HDMI](https://www.aja.com/products/ipt-10g2-hdmi) <br/> [IPT-10G2-SDI](https://www.aja.com/products/ipt-10g2-sdi) <br/> [IoIP](https://www.aja.com/products/io-ip) <br/> [KONA-IP](https://www.aja.com/products/kona-ip) | IS-04 v1.2 <br/> IS-05 v1.0 | IP Converters and Interfaces |
| AWS Elemental | [AWS Elemental Live](https://aws.amazon.com/elemental-live/) | IS-04 v1.3 <br/> IS-05 v1.1 | [Product Features](https://docs.aws.amazon.com/elemental-onprem/latest/pdf/AWS_Elemental_Data_Sheet_Live.pdf) <br /> [Specification Sheets](https://aws.amazon.com/elemental-live/resources/) | 
| Bridge Technologies | [VB440](https://bridgetech.tv/products/vb440/) | IS-04 v1.2 <br/> IS-05 v1.0 | High Performance IP Probe |
| Calrec | [Impulse](https://calrec.com/shop/broadcast-audio-consoles/impulse/) <br/> [Hydra2 IP Gateway](https://calrec.com/shop/audio-networking/gateway/) <br/> [Type-R Core](https://calrec.com/shop/broadcast-audio-consoles/type-r-for-radio/) <br/> [Type-R Analogue IO](https://calrec.com/shop/broadcast-audio-consoles/type-r-for-radio/) <br/> [Type-R Digital IO](https://calrec.com/shop/broadcast-audio-consoles/type-r-for-radio/) <br/> [Type-R Combo IO](https://calrec.com/shop/broadcast-audio-consoles/type-r-for-radio/) <br/> [Fixed Format IO](https://calrec.com/shop/audio-networking/hydra/) <br/> [Modular IO](https://calrec.com/shop/audio-networking/hydra/) | IS-04 v1.3 <br/> IS-05 v1.1 | Audio Mixing Console <br/> IP Gateway <br/> Audio Mixing Console <br/><br/> Various Gateways (Analogue, AES3, ST2110, AES67, MADI, SDI, Dante, Waves) <br/><br/> |
| Dalet | [Brio]( https://www.dalet.com/platforms/brio) | IS-04 v1.3 <br/> IS-05 v1.1 <br/> IS-08 v1.0 | Ingest and Playout Server |
| EEG | [HD492 Alta](https://eegent.com/products/X6KO3ARIL9X1VEIU/altaTM-ip-video-captioning) | IS-04 v1.2 <br/> IS-05 v1.0 | Caption Encoder for Live Broadcasting |
| Embrionix |see Riedel Communications GmbH|||
| Evertz | [ev670-X30-HW & -V2](https://evertz.com/products/ev670-X30-HW) <br/> [ev670-X45-HW](https://evertz.com/applications/sdvn/) <br/> [570IPG-X19-25G](https://evertz.com/applications/sdvn/) <br/> [670IPG-X19-25G-100G](https://evertz.com/applications/sdvn/) <br/> [570XS-HW-X19](https://evertz.com/applications/sdvn/)| IS-04 v1.3 <br/> IS-05 v1.3 <br/> IS-09 v1.0 <br/> BCP-002-01 |  Virtualized Media Processing Platform (Gateway, Processing, Multiviewer) <br/><br/> Gateways |
| EVS | [XT-VIA](https://evs.com/en/product/xt-via) <br/> [XS-VIA](https://evs.com/en/product/xs-via) <br/> [XT-4K](https://evs.com/en/product/xt4k) <br/> [XS-4K](https://evs.com/en/product/xs4k) <br/> [XS-NEO](https://evs.com/en/solutions/ingest2post) | IS-04 v1.2 <br/> IS-05 v1.0 | IP/SDI Production Servers |
| Grass Valley | [XIP-3901](https://www.grassvalley.com/products/xip-3901/) <br/>[Kaleido IP](https://www.grassvalley.com/products/kaleido-ip/) | IS-04 v1.2 <br/> IS-05 v1.0 | SDI/IP Processing Platform<br/>IP Video Multiviewer |
| Harmonic | [Spectrum X](https://www.harmonicinc.com/video-appliances-software/portfolio/spectrum-x/) | IS-04 v1.2 <br/> IS-05 v1.0 | Ingest and Playout Server | 
| Imagine Communications | [Selenio Network Processor](https://www.imaginecommunications.com/products/networking-infrastructure/processing/selenio-network-processor) <br/> [EPIC Multiviewer](https://www.imaginecommunications.com/products/networking-infrastructure/multiviewers/epic-mv) | IS-04 v1.2 <br/> IS-05 v1.0 | Network-based audio/video processor and gateway device <br/> IP-enabled Multiviewer |
| Leader | [LV5600](https://www.leader.co.jp/en/products/broadcast/waveform/lv5600/) <br/> [LV7600](https://www.leader.co.jp/en/products/broadcast/waveform/lv7600/) | IS-04 v1.2 <br/> IS-05 v1.0 | IP and SDI Hybrid Waveform / Rasterizer Monitor |
| Macnica | [VIPA](https://www.macnicatech.com/products/VIPA_PCIeCard) | IS-04 v1.2 <br/> IS-05 v1.0 | General purpose Video IP Accelerator.<br/> IP Gateway,  Multi-channel capture processing and playout of ST2110 streams. |
| Matrox | [X.mio5 Q25](https://www.matrox.com/video/en/products/developer/hardware/xmio5_Q25/) <br/> [DSX LE5 Q25/D25](https://www.matrox.com/video/en/products/developer/hardware/dsx_le5_Q25_D25/) <br/> [X.mio3 IP](https://www.matrox.com/video/en/products/developer/hardware/xmio3_ip/) <br/> <br/> [Matrox VERO](https://www.matrox.com/en/video/products/infrastructure/st2110-signal-generator-diagnostic-appliance/vero) | IS-04 v1.3 <br/> IS-05 v1.1 | ST.2110 & ST.2022-6 Network Cards <br/> <br/> <br/> <br/> ST 2110 Signal Generator & Diagnostic Appliance|
| Net Insight | [N600 Series](https://netinsight.net/products-and-services/nimbra/nimbra-product-specifications/#fusion-tab-nimbra600) | IS-04 v1.2 <br/> IS-05 v1.0 <br/> IS-08 v1.0 | Media transport and edge processing solution |
| Nevion | [Virtuoso MI](https://nevion.com/products/nevion-virtuoso/) | IS-04 v1.2 <br/> IS-05 v1.0 | Software defined media virtualization platform |
| Nextera Video | [NMOS Software Core](http://www.nexteravideo.com/nmos) | IS-04 v1.3 <br/> IS-05 v1.1 <br/> IS-07 v1.0 <br/> IS-08 v1.0 <br/> IS-09 v1.0 | Turnkey software core for FPGA embedded or standalone processor |
| NVIDIA <br/> (Mellanox) | [Rivermax SDK](https://developer.nvidia.com/networking/rivermax) for <br/> [ConnectX Family](https://www.nvidia.com/en-gb/networking/ethernet-adapters/) <br/> [BlueField Family](https://www.nvidia.com/en-gb/networking/products/data-processing-unit/) | IS-04 v1.3 <br/> IS-05 v1.1 <br/> IS-09 v1.0 | Software development kit for a fully-virtualized ST 2110 streaming solution, including NMOS integration | 
| Open Broadcast Systems | [C-200 Platform](https://www.obe.tv/portfolio/encoding-and-decoding/) | IS-04 v1.3 <br/> IS-05 v1.1 <br/> IS-09 v1.0 | Software-based encoding and decoding platform |
| Pebble | [Integrated Channel](https://www.pebble.tv/solutions/integrated-channel/) | IS-04 v1.3 <br/> IS-05 v1.1 | Software-defined integrated channel solution |
| Phabrix | [Qx](https://phabrix.com/products/qx/qx-series/) <br/> [SxTAG](https://phabrix.com/products/sx/tag/) | IS-04 v1.2 <br/> IS-05 v1.0 | IP/SDI generation, analysis and monitoring |
| Plura Broadcast | [SFP-25G](https://plurainc.com/solutions/monitors/) <br/> [SFP-25G-H](https://plurainc.com/solutions/monitors/) | IS-04 v1.2 <br/> IS-05 v1.0 <br/> IS-08 v1.0 <br/> IS-09 v1.0 <br/> BCP-002-01 v1.0 | 2110 IP Monitors |
| Riedel Communications GmbH & Co. KG|  [MediorNet FusioN](https://www.riedel.net/en/products-solutions/distributed-video-networks/mediornet-fusion/hardware/) <br/> [MediorNet MuoN](https://www.riedel.net/en/products-solutions/distributed-video-networks/mediornet-muon/hardware/) <br/> [MediorNet MicroN IP App](https://www.riedel.net/en/products/media-networks/mn-micron/ip-app/) <br/><br/><br/> [Artist Matrix Intercom](https://www.riedel.net/en/products-solutions/intercom/artist-matrix-intercom/hardware/) <br/> <br/>[Control Panel App for 1200 series Smartpanels](https://www.riedel.net/en/products-solutions/intercom/smartpanels/control-panel-app/)| IS-04 v1.2/1.3 <br/> IS-05 v1.0/1.1 <br/> IS-08 v1.0 <br/>IS-07 v1.0 (Control Panel App) | Gateway and Processing Devices <br/><br/><br/><br/><br> IP Intercom <br/><br/><br/> Universal Control Panel |
| Ross | [Ultrix-IP](https://www.rossvideo.com/ultrix) <br/> [Raptor](https://www.rossvideo.com/raptor) <br/> [Newt](https://www.rossvideo.com/newt) <br/> [Iggy](https://www.rossvideo.com/products-services/infrastructure/signal-processing/iggy-madi-aes67-st2110-to-madi-audio-converter/) | IS-04 v1.3 IS-05 v1.1 (Ultrix-IP)<br/> IS-04 v1.2 IS-05 v1.0 | Ultrix 12G Router IP Gateway <br/> IP/SDI Gateway <br/> IP/SDI/HDMI Gateway <br/> AES67 / MADI gateway |
| Sony | [HDCU-3000 Series](https://pro.sony/en_GB/products/camera-control-unit/hdcu-3500) <br/> [HDCU-5000 Series](https://pro.sony/en_GB/products/camera-control-unit/hdcu-5000) <br/> [HDCE-TX/RX Series](https://pro.sony/en_GB/products/camera-control-unit/hdce-tx30) <br/> [XVS Series](https://pro.sony/en_GB/products/video-switchers) <br/> [PWS-4500](https://pro.sony/en_GB/products/live-production-servers/pws-4500) | IS-04 v1.3 <br/> IS-05 v1.1 <br/> BCP-002-01 v1.0 | IP Ready Camera Control Units <br/> IP Ready Camera Extension Adaptor <br/> IP Ready Switcher Processor <br/> IP Ready Production Server |
| Synamedia | [Virtual Digital Content Manager (vDCM)](https://www.synamedia.com/wp-content/uploads/2021/11/VN-vDCM-Encoder-Datasheet.pdf) <br/>  <br/>  [Media Edge Gateway (MEG)](https://www.synamedia.com/wp-content/uploads/2021/11/VN-Media-Edge-Gateway-Datasheet.pdf) | IS-04 v1.3 <br/> IS-05 v1.1 <br/> BCP-002-01 v1.0 <br/> BCP-004-01 v1.0 | Software-based video multiplexer and compression system (encoder/transcoder) <br/> <br/> Cloud-native edge reception and processing platform |
| Telestream | [PRISM](https://www.telestream.net/video/prism.htm) | IS-04 v1.2 <br/> IS-05 v1.0 | Hybrid IP/SDI Monitoring Instrument. |
| Vizrt | [VizEngine 3.14](https://www.vizrt.com/products/viz-engine) | IS-04 v1.2 <br/> IS-05 v1.0 | Real Time Rendering Engine |

# Incubator Participants

Alongside those working on implementations of the finished specifications, many organisations actively participate in the specification development process including workshop events. The latest list of participating companies can be found at [nmos.tv](https://www.amwa.tv/nmos-supporters).
