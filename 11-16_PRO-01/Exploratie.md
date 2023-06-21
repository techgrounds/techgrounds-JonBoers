Als team willen wij duidelijk hebben wat de eisen zijn van de applicatie
Epic
Exploratie
Beschrijving
Je hebt al heel wat informatie gekregen. Er staan al wat eisen in dit document genoemd, maar deze lijst is mogelijk incompleet of onduidelijk. Het is belangrijk om alle onduidelijkheden uitgezocht te hebben voordat je groot werk gaat verzetten.
Deliverable
Een puntsgewijze omschrijving van alle eisen: 

* Alle VM disks moeten encrypted zijn.  
* De webserver moet dagelijks gebackupt worden.  
* De backups moeten 7 dagen behouden worden.
* De webserver moet op een geautomatiseerde manier geïnstalleerd worden.
* De admin/management server moet bereikbaar zijn met een publiek IP.
* De admin/management server moet alleen bereikbaar zijn van vertrouwde locaties (office/admin’s thuis)
* De volgende IP ranges worden gebruikt: 10.10.10.0/24 & 10.20.20.0/24
* Alle subnets moeten beschermd worden door een firewall op subnet niveau. 
* SSH of RDP verbindingen met de webserver mogen alleen tot stand komen vanuit de admin server. 
* Wees niet bang om verbeteringen in de architectuur voor te stellen of te implementeren, maar maak wel harde keuzes, zodat je de deadline kan halen.

Punten van feedback product owner:

* Er wordt gebruik gemaakt van een nieuwsdienst
* Er zullen generic workstations gebruikt worden
* Hoe meer marketing wij doen, hoe meer mensen er naar de website komen.
* Het is geen webwinkel
* Netwerksegmentatie is gewenst ivm veiligheid.
* Klanten zitten voor het grootste gedeelte in NL, maar ook in DE en BE.
* Admin gebruikers zitten in NL (management server)
* Admin server moet een windows 2022 VM zijn 
* Principle of least privilege
* Intrusion detection system wordt door het security team gebouwd.
* Er moet een database worden gebruikt voor de nieuwsdienst
* Alleen een gratis variant van de AD, premium is te duur.
* Er wordt geen gebruik gemaakt van reserved instances. Per definitie niet in een development omgeving.
* Er zullen tussen de 50-100 workstations zijn. IP-adressen hoeven niet gereserveerd te worden.
Deze workstations (VM's) zullen later door de admin worden toegevoegd via de admin server.
* Post deployment scripts zijn voor eenmalig gebruik, maar ze moeten wel ergens kunnen worden opgeslagen.

---

Als team willen wij een duidelijk overzicht van de aannames die wij gemaakt hebben.

Epic: Exploratie

Beschrijving:

Je hebt al heel wat informatie gekregen. Mogelijk zijn er vragen die geen van de stakeholders heeft kunnen beantwoorden. Je team moet een overzicht kunnen produceren van de aannames die je daardoor maakt.
Deliverable

Een puntsgewijs overzicht van alle aannames:

* voor de nieuwsbrief is het gebruik van logicapps het meest voor de hand liggend
* ~~voor de VM-scaleset is een load-balancer nodig om eventuele pieken te kunnen opvangen~~
15/06: een scaleset lijkt overkill te zijn voor de verwachte pieken dus deze aanname wordt geschrapt.
* voor de webserver lijkt Azure Bastion een goede optie omdat ip-adressen niet gereserveerd hoeven te worden. Hiermee kan er verbinding worden gemaakt met SSH en RDP zonder de ports bloot te stellen.
* voor de management server is naast de NSG ~~ook een private link gewenst. (hier nog niet zeker over)~~
16/06: private link is niet nodig, NSG is genoeg voor de requirements dus geschrapt.
---

Als team willen wij een duidelijk overzicht hebben van de Cloud Infrastructuur die de applicatie nodig heeft
Epic: Exploratie  

Beschrijving:  

Je hebt al heel wat informatie gekregen. En al een ontwerp. Alleen in het ontwerp ontbreken nog zaken als IAM/AD. Identificeer deze extra diensten die je nodig zal hebben en maak een overzicht van alle diensten.

Deliverable:

Een overzicht van alle diensten die gebruikt gaan worden.

* VM Scaleset
* Nic's
* NSG
* 2 subnets
* Storage account
* webserver
* admin server
* active directory (gratis variant)
* conditional access, MFa
* key vault
* database voor nieuwsdienst 

* firewalls 




