# Handleiding voor het starten van de main.bicep template

## Vereisten:

Als u geen abonnement op Azure hebt, maakt u een gratis account voordat u begint.

De link om dit te doen vindt u [hier](https://azure.microsoft.com/en-us/free/)

Er moet over de juiste machtigingen beschikt kunnen worden om resources te implementeren binnen het gekozen abonnement.

### Azure CLI of Azure PowerShell: 

Om het main.bicep-bestand te implementeren, heeft u de Azure Command-Line Interface (CLI) of Azure PowerShell nodig. Beide tools kunnen worden gebruikt om het implementatieproces uit te voeren.

Bicep-bestand (main.bicep): Zorg ervoor dat het main.bicep-bestand is opgeslagen op uw lokale machine of een toegankelijke locatie in de cloud. U kunt het pad naar het bestand noteren of onthouden voor implementatiedoeleinden. Let erop dat de aparte modules ook in een aparte map "modules" in de bestandlocatie worden opgeslagen.

[Azure CLI installeren in Windows](https://learn.microsoft.com/nl-nl/cli/azure/install-azure-cli-windows?tabs=azure-cli)  

[Azure CLI installeren in Linux](https://learn.microsoft.com/nl-nl/cli/azure/install-azure-cli-linux?pivots=apt)  

[Azure CLI installeren in macOS](https://learn.microsoft.com/nl-nl/cli/azure/install-azure-cli-macos)  

Voer het volgende uit om uw huidige versie te controleren:

Azure CLI:

```
az --version
```

Gebruik het volgende om uw Bicep CLI-installatie te valideren:

```
az bicep version
```

Als u wilt upgraden naar de nieuwste versie, gebruikt u:

```
az bicep upgrade
```

### Azure PowerShell

U moet Azure PowerShell versie 5.6.0 of hoger hebben geïnstalleerd. Zie [Azure PowerShell installeren](https://learn.microsoft.com/nl-nl/powershell/azure/install-azure-powershell?view=azps-10.1.0) om Azure PowerShell bij te werken of te installeren.

Azure PowerShell installeert de Bicep CLI niet automatisch. In plaats daarvan moet u de [Bicep CLI handmatig installeren](https://learn.microsoft.com/nl-nl/azure/azure-resource-manager/bicep/install#install-manually).  

Nu kan het implementatieproces gestart worden:

Open een opdrachtprompt of terminal en navigeer naar de locatie waar het main.bicep-bestand zich bevindt.

Implementeer de main.bicep-template naar de vooraf geselecteerde regio (uksouth) en de resourcegroep die je al hebt aangemaakt in de main.bicep-template met behulp van de Azure CLI. Gebruik het volgende commando:

powershell:
```
New-AzSubscriptionDeployment -Location uksouth -TemplateFile main.bicep
```
Er is hier gekozen voor de regio uksouth omdat de goedkoopste regio is. Mocht u in de toekomst willen switchen naar een andere regio dan kan dit door de location parameter aan te passen. Klik [hier voor een uitleg over Azure regions](https://azure.microsoft.com/en-us/explore/global-infrastructure/geographies/)

Na het geven van het powershell commando zal er om de volgende parameters gevraagd worden:

* Environment: (voor een testomgeving voer 'dev' in, voor een productie omgeving voer 'prod' in) Het verschil in deze parameter zit 'm in de kosten en redundancy. Bij 'dev' zal er deployed worden met 'local rendundant storage'(LRS) wat 3 copy's maakt in hetzelfde datacenter, maar goedkopger dan 'geo redundant storage' (GRS) wat een hogere SLA geeft en fault tolerance, maar duurder is. Bij GRS worden er reserve copy's gemaakt als bij LRS plus extra copy's in een fysieke locatie in de secundaire regio. Binnen de secundaire regio worden uw gegevens drie keer synchroon gekopieerd met behulp van LRS.
* webadmin_username: <een username naar keuze voor de webserver>
* webadmin_password: <passwodrd naar keuze voor de webserver>

* ManadminUsernam: <een username naar keuze voor de management server>
* ManadminPassword: <password naar keuze voor de management server>

* mySQLAdminUsername:<een username naar keuze voor de database server>
* dbAminLoginPassword: <password naar keuze voor de database server>




Zodra deze stappen zijn doorlopen, zal Azure de resources implementeren op basis van de inhoud van het main.bicep-bestand in de opgegeven regio.