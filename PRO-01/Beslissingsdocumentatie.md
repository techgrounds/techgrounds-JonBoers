### Beslissing Documentatie

Tijdens het implementeren van het ontwerp zal je beslissingen maken over o.a. diensten die je gaat gebruiken.  

In dit document zal je je overwegingen uitschrijven en je besluiten onderbouwen.  

Dit document zal ook al je assumpties en verbeteringen bevatten.  

Dit dient als basis voor je ontwerp documentatie.

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



