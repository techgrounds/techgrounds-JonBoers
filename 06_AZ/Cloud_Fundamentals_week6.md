# Onderwerpen Cloud Fundamentals Week 6

Introductie:
Welkom bij de laatste week voor het examen waarin wij nog nieuwe onderwerpen introduceren. Volgende week zullen wij vooral voorbereidingen treffen voor het certificeringsexamen.

Tijdens het leren voor dit examen zal je hoogstwaarschijnlijk nog nieuwe diensten tegen komen tijdens, bijvoorbeeld, oefenexamens. Je zult deze nieuwe diensten ook moeten kennen. Het detail wat je moet weten voor het examen is alleen niet zo hoog als je hiervoor met de behandelende diensten heb gedaan.

Vragen die je kan stellen over nieuwe diensten die je tegen komt:
Waar is X voor?
Waar wordt X voor gebruikt?
Zoals je kan zien is dit lijstje stukken korter dan wat wij hiervoor hebben behandeld.

Hier zijn nogmaals de lijstjes vragen voor je onderzoek:
Vragen voor theoretisch onderzoek:
Waar is X voor?
Hoe past X / vervangt X in een on-premises setting?
Hoe kan ik X combineren met andere diensten?
Wat is het verschil tussen X en andere gelijksoortige diensten?

Vragen voor praktisch onderzoek:
Waar kan ik deze dienst vinden in de console?
Hoe zet ik deze dienst aan?
Hoe kan ik deze dienst koppelen aan andere resources?

## Key-terms

----
**Containers**: Een standaardpakket van software bundelt de code van een toepassing samen met de bijbehorende configuratiebestanden, bibliotheken en afhankelijkheden die nodig zijn om de app uit te voeren. Op die manier kunnen ontwikkelaars en IT-professionals toepassingen naadloos in verschillende omgevingen implementeren.
[Documentatie over containers](https://azure.microsoft.com/nl-nl/resources/cloud-computing-dictionary/what-is-a-container)  

**Azure Support Plans**: (4 niveaus)  
*Basic*: Gratis, geen actieve Azure support.

*Developer*: eur29/mnd, actieve support via email, 8hr response-tijd, voor test- en niet-productie omgevingen.

*Standard*: eur100/mnd, 24/7 support, 1hr response-tijd, voor productieomgevingen.

*Professional Direct*: eur1000/mnd, 24/7 support + operational support + training + proactieve hulp, 1hr response-tijd, noodzakelijk voor zakelijk kritieke omgevingen.  
[Documentatie over Azure Support Plans](https://azure.microsoft.com/nl-nl/support/plans)  

**Azure Advisor**: Gratis 'handleiding' of 'gids' die adviseert op basis van het 'Well-Architected Framework' van Azure. Beschikbaar in de portal.
[Documentatie over Azure Advisor](https://azure.microsoft.com/nl-nl/products/advisor#features)

**Azure APP Configuration**: 

*provides a service to centrally manage application settings and feature flags*. Modern programs, especially programs running in a cloud, generally have many components that are distributed in nature. Spreading configuration settings across these components can lead to hard-to-troubleshoot errors during an application deployment. Use App Configuration to store all the settings for your application and secure their accesses in one place.

The [Twelve-Factor App](https://12factor.net/) describes many well-tested architectural patterns and best practices for use with cloud applications. One key recommendation from this guide is to *separate configuration from code*. 

Examples that benefit from the use of it:
* containerized apps
* serverless apps which include event-driven stateless compute app
* continuous deployment pipeline (CD, as in CI/CD)

[Documentatie over Azure Ap Configuration](https://learn.microsoft.com/en-us/azure/azure-app-configuration/overview)

*Feature flags* are a software development concept that allow you to enable or disable a feature without modifying the source code or requiring a redeploy. They are also commonly referred to as feature toggles, release toggles or feature flippers. Feature flags determine at runtime which portions of code are executed.

Feature flags (also known as feature toggles) are if-statements in the code base that enable teams to turn features on or off.

**Azure Activity Log**: is a platform log in Azure that provides insight into subscription-level events. The activity log includes information like when a resource is modified or a virtual machine is started. You can view the activity log in the Azure portal or retrieve entries with PowerShell and the Azure CLI. 

* Retained for 90 days and then deleted. 
* Entries in the Activity Log are system generated and can't be changed or deleted.
* Entries in the Activity Log are representing control plane changes like a virtual machine restart, any non related entries should be written into Azure Resource Logs
* You can access the activity log from most menus in the Azure portal.

[Documentatie over Azure Activity Log](https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/activity-log?tabs=powershell)

-----

## Opdracht

**Azure Active Directory**			/ IAM

**Azure Monitor**					/ AWS Cloudwatch

**CosmosDB** 					/ DynamoDB

**Azure Functions** 				/ AWS Lambda
* Serverless coding platform (Functions as a Service, FaaS)
* Designed for nano-service architectures and event-based applications
* Scales up and down very quickly 
* Highly scalable
* Supports popular languages and frameworks  
(.NET & .NET Core, Java, Node.js, Python, Powershell, etc.)



**Event Grid, Queue Storage, Service Bus** 	/ SNS, SQS, Event Bridge


### Gebruikte bronnen

learn.microsoft  
wiki  


### Ervaren problemen

### Resultaat

