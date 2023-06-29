### Beslissing Documentatie

Tijdens het implementeren van het ontwerp zal je beslissingen maken over o.a. diensten die je gaat gebruiken.  

In dit document zal je je overwegingen uitschrijven en je besluiten onderbouwen.  

Dit document zal ook al je assumpties en verbeteringen bevatten.  

Dit dient als basis voor je ontwerp documentatie.
---
#### Als klant wil ik een werkende applicatie hebben waarmee ik een veilig netwerk kan deployen

v1.0
*Beschrijving*  

De applicatie moet een netwerk opbouwen dat aan alle eisen voldoet. Een voorbeeld van een genoemde eis is dat alleen verkeer van trusted sources de management server mag benaderen.

*Deliverable*  

IaC-code voor het netwerk en alle onderdelen

---

*Vereisten*

*   De admin/management server moet alleen bereikbaar zijn van vertrouwde locaties (office/admin’s thuis)  
*   De volgende IP ranges worden gebruikt: 10.10.10.0/24 & 10.20.20.0/24  
*   Alle subnets moeten beschermd worden door een firewall op subnet niveau.  
*   De VM's moeten met Ubuntu OS worden opgezet

#### management-prg-vnet

Om te voldoen aan de eis dat alleen verkeer van vertrouwde bronnen toegang mag hebben tot de management server overwoog ik het volgende:

Network Security Group (NSG): Er zullen NSG-regels geconfigureerd dienen te worden om alleen verkeer van vertrouwde bron-IP-adressen of IP-bereiken toe te staan.

Private Link: Private Link maakt het mogelijk om veilig toegang te krijgen tot het storage account en de database via een privéverbinding binnen het VNet. Met Private Link kan alleen verkeer van vertrouwde bronnen binnen het VNet de management server bereiken. [Info over private link](https://learn.microsoft.com/en-us/azure/private-link/private-link-overview)
15/06 wellicht dat NSG voldoende is om de management server veilig te houden. Meer research is nodig.
16/06 NSG is voldoende het idee van Private link geschrapt.

Ook overwoog ik om Conditional Access in te bouwen, maar dit is alleen beschikbaar met de premium variant van Azure AD dus deze optie kwam te vervallen.

#### app-prg-vnet

* ~~~~Het gebruik van Bastion is een goede optie, dit ga ik in ieder geval in V1.0 inbouwen.~~~~ 29/06: Dit idee geschrapt omdat de webservers toch alleen maar vanuit de admin vm benaderd hoeven te worden en dit gaat via SSH.
* De regio wordt UK south omdat Azure aangeeft dat dit het goedkoopste is en dichtbij genoeg voor de scope van de klant.

---
### Als klant wil ik een MVP kunnen deployen om te testen  
Epic  
v1.0  
Beschrijving  

De klant wil zelf intern je architectuur testen voordat ze de code gaan gebruiken in productie. Zorg ervoor dat er configuratie beschikbaar is waarmee de klant een MVP kan deployen.  

Deliverable  
Configuratie voor een MVP deployment

Overweging:

```
@allowed([
  'nonprod'
  'prod'
])
param environmentType string
```
en: 

```
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
var appServicePlanSkuName = (environmentType == 'prod') ? 'P2V3' : 'F1'
```
uitleg: Low cost sku for testing in a nonproduction environment.
bron: https://learn.microsoft.com/en-us/training/modules/build-first-bicep-template/5-add-flexibility-parameters-variables (page 5/10, 'Selecting SKUs for resources')



