# [Network Devices]

Introductie:
Er bestaat geen netwerk zonder netwerkapparatuur als je meer dan twee computers aan elkaar wilt schakelen. 

Een korte, en zeker niet complete, lijst van netwerkapparatuur volgt:
router
switch
repeaters
access point 

Elk apparaat in de lijst draagt eraan bij dat je data bezorgd wordt bij de juiste computer. En vaak zijn ze slim genoeg om samen te onderhandelen zodat jij, als gebruiker, geen zorgen hoeft te maken over de instellingen. Je netwerkapparaten blijven het doen zelfs als je computers toevoegt of verwijdert van je netwerk. Protocollen spelen hierin een belangrijke rol.

Implementaties van netwerkapparatuur kunnen ook verschillen: er bestaan meerdere vormen van een switch die werken op verschillende lagen van het OSI-model.

AWS en Azure bieden diensten aan die gelijk zijn aan wat netwerkapparatuur doen. En ieder netwerkconcept (routing, switching, gateways) heeft één of meerdere cloud equivalenten.

Bestudeer:
Netwerkapparaten
Het OSI model in relatie tot deze netwerkapparaten

Benodigdheden:
Je eigen netwerk
Admin toegangsgegevens voor je router
NOOT: Als je geen admin-toegang hebt, bijvoorbeeld omdat je in een appartementencomplex met gedeelde wifi woont, neem dan via Zoom het scherm over van een teamgenoot, en doe zo de opdracht.

## Key-terms
DHCP; (Dynamic Host Configuration Protocol) A network management protocol used to automate the process of configuring devices on IP networks. It dynamically assigns an IP address and other network configuration parameters to each device on a network so they can communicate with other IP networks.

MAC-address; 
IP-address
Connected type 
RSSI
Remaining lease time


## Opdracht
### Gebruikte bronnen

https://www.youtube.com/watch?v=9eH16Fxeb9o&list=PLIhvC56v63IJVXv0GJcl9vO5Z6znCVb1P&index=2
https://www.efficientip.com/what-is-dhcp-and-why-is-it-important/

### Ervaren problemen

Fell into the Rabbit hole.

### Resultaat

Opdracht:
Benoem en beschrijf de functies van veel voorkomend netwerkapparatuur

Router: A device that connects multiple networks and routes data packets between them. (OSI layer 3)

Switch: A device that connects multiple devices in a local area network (LAN) and directs traffic between them. (OSI layer 2)

Firewall: A security device that monitors and controls incoming and outgoing network traffic based on predetermined security rules. (OSI layer 3 or 4)

Access point: A device that allows devices to connect to a wireless network. (OSI layer 1 when it converts data into radio signal layer 2 to provide the IEEE 802.11 protocol to provide wireless connectivity to devices.)

Load balancer: A device that distributes network traffic across multiple servers to improve performance and availability. (OSI layer 4 or 7)

Proxy server: A server that acts as an intermediary between clients and servers, often used for content filtering and caching. (OSI layer 7)

VPN concentrator: A device that creates secure remote access connections for users to connect to a private network over the internet. (OSI layer 3 and 4)

Intrusion detection/prevention system (IDS/IPS): A security device that monitors network traffic for suspicious activity and can block or alert on detected threats. (OSI layers 2,3 and 4)

Network attached storage (NAS): A device that provides centralized storage for multiple devices on a network. (OSI layer 2 and 3)

Unified threat management (UTM) device: A security appliance that combines multiple security features, such as firewall, VPN, IDS/IPS, and content filtering, into a single device for simplified management. (OSI  layer 3 and 4)

Repeaters: Amplifies or regenerates signals received on one network segment and rebroadcasts them to another network segment. It is used to extend the reach of a network beyond its normal physical limitations, and can help to overcome signal attenuation and loss over long distances. Repeaters are commonly used in wired networks such as Ethernet, as well as in wireless networks such as Wi-Fi. (OSI layer 1 and 2)
 
Hub: Connects multiple devices together in a local area network (LAN) and forwards data packets between them. Operates at the physical layer (Layer 1) of the OSI model, which means it is responsible for transmitting signals between devices on the same network segment. When a device sends data to another device on the same network, the data is broadcast to all connected devices on the hub, regardless of the destination address. This makes hubs inefficient for large networks, as they can generate a lot of unnecessary traffic and cause network congestion. (OSI layer 1)

De meeste routers hebben een overzicht van alle verbonden apparaten, vind deze lijst. 

![Alt text](../00_includes/Week2/Network%20devices1.PNG)

Welke andere informatie heeft de router over aangesloten apparatuur?

MAC-address
IP-address
Connected type 
RSSI
Remaining lease time for this IP-address

Waar staat je DHCP server op jouw netwerk? Wat zijn de configuraties hiervan?

![Alt text](../00_includes/Week2/Network%20devices2.PNG)

DHCP server has the same IP as my router so it's there. Autoconfiguration is enabled.

Also the configuration information from the web gui:

![Alt text](../00_includes/Week2/Network%20devices3.PNG)