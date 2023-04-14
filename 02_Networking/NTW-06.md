# Subnetting

Introductie:
Een netwerk is gedefinieerd als twee of meer devices die met elkaar verbonden zijn zodat ze data kunnen uitwisselen. Een Local Area Network (LAN) wordt vaak uitgedrukt als een range aan IP addresses. Elk device (host) krijgt een eigen adres binnen die range.

Om dit te ondersteunen hebben netwerken een subnet mask (prefix) die definieert hoeveel bits van het IP adres onderdeel uitmaken van het netwerkadres, en hoeveel bits gereserveerd zijn voor de host.

Een subnet is een kleiner netwerk dat onderdeel is van een groter netwerk. Subnets kunnen worden gebruikt om een deel van het netwerk logisch te isoleren. Een subnet heeft per definitie een grotere prefix dan het netwerk waar het subnet in zit.

Om dit alles leesbaar te maken voor mensen maken we gebruik van CIDR notation.

Benodigdheden:
https://app.diagrams.net/
Een subnet calculator

## Key-terms
CIDR (Classless Inter-Domain Routing) is a method of IP address allocation and routing that replaces the traditional Class A, B, and C networks. It allows for more efficient use of IP address space by enabling the allocation of variable-length subnet masks (VLSMs) that can divide a larger network into smaller subnets.

CIDR uses a notation that includes the IP address followed by a forward slash (/) and a number indicating the length of the prefix, which is the number of bits used to identify the network. For example, the CIDR notation for a network with an IP address of 192.168.0.0 and a subnet mask of 255.255.255.0 would be 192.168.0.0/24, where the prefix length is 24 bits.

CIDR is important for internet routing because it enables more efficient use of IP address space, which is limited. By dividing the available address space into smaller subnets, CIDR allows for more specific routing information to be shared among routers, reducing the size of routing tables and improving the speed and efficiency of internet traffic.

## Opdracht
### Gebruikte bronnen
https://www.dnsstuff.com/subnet-ip-subnetting-guide#what-are-subnets-used-for
https://davidbombal.com/subnetting-concepts-calculator/


### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat

Opdracht:
Maak een netwerkarchitectuur die voldoet aan de volgende eisen:
1 private subnet dat alleen van binnen het LAN bereikbaar is. Dit subnet moet minimaal 15 hosts kunnen plaatsen.
1 private subnet dat internet toegang heeft via een NAT gateway. Dit subnet moet minimaal 30 hosts kunnen plaatsen (de 30 hosts is exclusief de NAT gateway).
1 public subnet met een internet gateway. Dit subnet moet minimaal 5 hosts kunnen plaatsen (de 5 hosts is exclusief de internet gateway).
Plaats de architectuur die je hebt gemaakt inclusief een korte uitleg in de Github repository die je met de learning coach hebt gedeeld.
Zie hier een voorbeeld van hoe je een netwerkarchitectuur kan visualiseren:

