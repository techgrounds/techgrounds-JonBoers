### Tijd logs
Dit is een bestand waarin je gestructureerd je dagen bijhoudt.  
Je geeft aan in 1 enkele zin waar je aan gewerkt hebt die dag.  
Puntsgewijs zal je de obstakels aangeven die je hebt ervaren en de oplossingen die je hebt gevonden.

---

# Log 05/06
Bezoek Uber hoofdkantoor Amsterdam

## Dagverslag (1 zin)
Q&A met CEO Uber en Head EMEA en engineers

## Obstakels
Niet kunnen werken aan project

## Oplossingen
Tijd inhalen door goed te plannen

## Learnings
Geschiedenis, werking en langetermijn visie uber.

---

# Log 06/06
Planning project
## Dagverslag (1 zin)
Project eisen doorgenomen, user stories, architecture, planning gemaakt, Bicep documentatie en video cursus.

## Obstakels
Hoe te beginnen???

## Oplossingen
Beginnen bij het begin.

## Learnings
Bicep intro. hoe zet ik m'n omgeving klaar. version checks. Installeren van Bicep CLI,
Azure CLI en AZ Module.

Trello hoe werken kaarten en boards.

---

# Log 07/06
Explore epic
## Dagverslag (1 zin)

Microsoft learn bicep modules en requirements mvp doorgenomen

## Obstakels


## Oplossingen


## Learnings

Requirements MvP, werkwijze bicep templates, fout correcties. Azure fundamentals refreshed.

---

# Log 08/06
Explore epics
bicep template

## Dagverslag (1 zin)

Verder verdiept in Bicep tutorials en explore epics geupdate.

## Obstakels


## Oplossingen


## Learnings

---

# Log 09/06
Explore epics
bicep template

## Dagverslag (1 zin)

Verder verdiept in Bicep tutorials.

## Obstakels


## Oplossingen


## Learnings

---

# Log 12/06

bicep template

## Dagverslag (1 zin)

Verder verdiept in Bicep tutorials.

## Obstakels


## Oplossingen


## Learnings

---

# Log 13/06

bicep template

## Dagverslag (1 zin)

Verder verdiept in Bicep tutorials.

## Obstakels


## Oplossingen


## Learnings

---

# Log 14/06

bicep template

## Dagverslag (1 zin)

Bezig geweest met de portal, het aanmaken van templates en json transpiled naar bicep om een
indruk te krijgen van de opbouw.

## Obstakels

Uitkomst was complexer dan ik dacht en niet alle features werden ondersteund.

## Oplossingen

Dit is geen benadering om het project te bouwen, maar er komen goede inzichten en suggesties uit.

## Learnings

---

# Log 15/06

bicep templates en exploration

## Dagverslag (1 zin)

Bezig geweest met transpilen van vnet en vm (json) templates naar bicep en verder onderzoek naar beste opties voor de requirements.

## Obstakels


## Oplossingen


## Learnings

Het nut van projectmatig werken wordt steeds duidelijker, maar moeilijk om dit toe te passen. 
Wel wordt het werken er overzichtelijker van.
---

# Log 16/06

bicep templates en exploration

## Dagverslag (1 zin)

Les en bouwen aan app-prd-vnet inclusief 2 vm's en bastion.

## Obstakels


## Oplossingen


## Learnings

---

# Log 19/06

vnet 1 deployed en diagram

## Dagverslag (1 zin)

Ontwerp diagram gemaakt en trello board aangepast.

## Obstakels


## Oplossingen


## Learnings

diagram tekenen
trello board
---

# Log 20/06

Vorderingen

## Dagverslag (1 zin)

Webserver aangepast naar ubuntu, locatie aangepast, gewerkt aan apache server.

## Obstakels

Nog niet de juiste methodiek kunnen ontdekken om de apache server te deployen.

## Oplossingen

Wel wat goede opties onderzocht, zoals custom script extension of misschien een verwijzing
naar het bash script via een parameter.

## Learnings

custom scripts
base64

---

# Log 21/06


## Dagverslag (1 zin)

Gewerkt aan schema (ontwerp), vnet2, keyvault en webserver.

## Obstakels



## Oplossingen



## Learnings

---
# Log 22/06


## Dagverslag (1 zin)

Gewerkt aan het moduleren van diverse onderdelen. 

## Obstakels

Sommige parameters worden dubbel gedeclareerd op deze manier dus het is puzzelen om alles opnieuw door te nemen.

## Oplossingen



## Learnings

modules

---

# Log 26/06


## Dagverslag (1 zin)

Foutcodes weggewerkt, beide vnets deployen nu zonder problemen, verder gewerkt aan peering module.

## Obstakels

Problemen met verwijzingen en naamgevingen werden blootgelegd.

## Oplossingen

Logischere naamgeving moet worden gecorrigeerd. Validatie nog fixen.

## Learnings

werken met outputs

---

# Log 27/06


## Dagverslag (1 zin)

Peering gelukt, verder gewerkt aan webserver apache script en nsg's en publieke ip's.

## Obstakels

Problemen met verwijzingen en naamgevingen. param's gewijzigd van webservers en managementservers.

## Oplossingen

Naamgeving na logisch nadenken en hulp aangepast, deployment gelukt. Apache script lijkt te werken, maar
kan nog niet testen. 

## Learnings

---

# Log 28/06


## Dagverslag (1 zin)

Apachi script succesvol getest en NSG regels voor webserver toegevoegd, verbonden en deployed.

## Obstakels

Aangenomen dat verbindingen tussen NSG, public ip's en loadbalancer automatisch werden gelegd. Was niet zo.

## Oplossingen

Verwijzingen gelegd voor webserver vnet. Voor management server nog bezig...

## Learnings

---

# Log 29/06


## Dagverslag (1 zin)

NSG regels voltooid, juiste verbindingen gelegd met public ip >> man-prd-vnet en storageaccount >> management vm keyvault en diskencryption verkend en ingelezen alsmede eerste opzet.

## Obstakels

Benamingen met outputs zijn voor mij nog steeds onoverzichtelijk en een puzzel, keyvault een hoofdstuk apart.

## Oplossingen

## Learnings

Hoe werken outputs.
Hoe werkt een keyvault.
Hoe werkt diskencryption.

---

# Log 30/06

## Dagverslag (1 zin)

Retrospectives gedaan en verder gewerkt aan keyvault.

## Obstakels

keyvault concepten en hoe het linkt met disk encryption is een moeilijk concept.

## Oplossingen

Veel hulp zoeken bij anderen.

## Learnings

---

# Log 03/07

## Dagverslag (1 zin)

Na nieuwe requirements voor v1.1 verdiept in Application gateway, health checks en listeners en een begin gemaakt met een scaleset.

## Obstakels

## Oplossingen

## Learnings

application gateway
listeners
health checks
scalesets

---

# Log 04/07

## Dagverslag (1 zin)

## Obstakels

## Oplossingen

## Learnings

[TLS1.2:](https://learn.microsoft.com/nl-nl/mem/configmgr/core/plan-design/security/enable-tls-1-2)

[Load balancing vs reverse proxy:](https://www.nginx.com/resources/glossary/reverse-proxy-vs-load-balancer/)

---

# Log 10/07

## Dagverslag (1 zin)

VMSS aan de praat gekregen en verwijzingen gecorrigeerd.

## Obstakels

Outputs kunnen verwarrend zijn als je werkt met modules en foutopsporing daardoor lastig.

## Oplossingen

Team mee laten kijken en een verse ogen helpen.

## Learnings

Vraag om hulp.

---

# Log 11/07

## Dagverslag (1 zin)
Gewerkt aan mySQL database, maar geen resultaat.

## Obstakels

foutmeldingen en endpoint.

## Oplossingen

andere methode voor de volgende dag.

## Learnings

mySQL
---

# Log 12/07

## Dagverslag (1 zin)

Verder gewerkt aan mySQL, maar nu met VM en met de groep

## Obstakels



## Oplossingen



## Learnings