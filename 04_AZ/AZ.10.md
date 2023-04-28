# Azure Virtual Network (VNet)

Introductie:
Azure virtual networks (VNets) zorgen ervoor dat resources als VMs, web apps en databases kunnen communiceren met elkaar, met gebruikers op het internet en met machines die on-premises staan.

VNets hebben de volgende verantwoordelijkheden:
* (Netwerk-)isolatie en -segmentatie
* Internetcommunicatie
* Communicatie tussen Azure resources
* Communicatie met on-premises resources
* Routeren van netwerkverkeer
* Filteren van netwerkverkeer
* Verbinden aan andere VNets

Wanneer je een nieuw VNet aanmaakt, bepaal je een private IP range voor je netwerk. Binnen die range kan je subnets aanmaken.

Er zijn drie manieren om je netwerk te verbinden aan een on-premises netwerk:
* Point-to-site VPNs:
    * Het Azure VNet wordt benaderd met een VPN vanaf een on-prem computer.
* Site-to-site VPNs:
    * De on-prem VPN device of gateway wordt verbonden met de Azure VPN Gateway. Hierdoor krijg je effectief 1 groot local network.
* Azure Expressroute:
    * Dit is een fysieke verbinding vanaf je lokale omgeving naar Azure.

Je kan ook twee Azure VNets met elkaar verbinden door middel van virtual network peering. Dit wordt mogelijk gemaakt door user-defined Routing (UDR). Peering is mogelijk met VNets in verschillende regions.

Benodigdheden:
Je Azure Cloud omgeving (link)

## Key-terms
[Schrijf hier een lijst met belangrijke termen met eventueel een korte uitleg.]

## Opdracht

Opdracht 1:
* Maak een Virtual Network met de volgende vereisten:
    * Region: West Europe
    * Name: Lab-VNet
    * IP range: 10.0.0.0/16
* Vereisten voor subnet 1:
    * Name: Subnet-1
    * IP Range: 10.0.0.0/24
    * Dit subnet mag geen route naar het internet hebben
* Vereisten voor subnet 2:
    * Name: Subnet-2
    * IP Range: 10.0.1.0/24

Opdracht 2:
Maak een VM met de volgende vereisten:
Een apache server moet met de volgende custom data geïnstalleerd worden:

```

#!/bin/bash
sudo su
apt update
apt install apache2 -y
ufw allow 'Apache'
systemctl enable apache2
systemctl restart apache2

```
*    * Er is geen SSH access nodig, wel HTTP
     * Subnet: Subnet-2
     * Public IP: Enabled

Controleer of je website bereikbaar is
### Gebruikte bronnen
https://learn.microsoft.com/en-us/azure/virtual-network/quick-create-portal

### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
[Omschrijf hoe je weet dat je opdracht gelukt is (gebruik screenshots waar nodig).]
