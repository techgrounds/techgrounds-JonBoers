# Asymmetric encryption

Introduction:
The previous assignment introduced you to cryptography and symmetric encryption. In the previous exercise, you shared your encryption key with the recipient of your message. This means that anyone who has the key can decrypt the message.

Asymmetric encryption solves this issue. Instead of 1 key, you get 2: A public key, and a private key.

Requirements:
The Slack channel your share with your entire cohort
A peer
A key pair generator like https://travistidwell.com/jsencrypt/demo/

## Key-terms
[Schrijf hier een lijst met belangrijke termen met eventueel een korte uitleg.]

## Opdracht
### Gebruikte bronnen
https://www.simplilearn.com/tutorials/cryptography-tutorial/rsa-algorithm#:~:text=When%20using%20RSA%20for%20encryption,any%20keys%20in%20this%20scenario  
https://www.devglan.com/online-tools/rsa-encryption-decryption#:~:text=RSA(Rivest%2DShamir%2DAdleman,to%20decrypt%20the%20encrypted%20message.

### Ervaren problemen

### Resultaat

**Exercise:**

**Generate a key pair.**

To be practical i pasted the keys here although I understand that this is unsafe.

-----BEGIN RSA PRIVATE KEY-----
MIICWgIBAAKBgFGBp2kNZlPJOxYeBbmQ0P6YQD/EGjmg/Tq+H/AKAzK9GsvdP3dX
DfRMax71or5hLYPIpRNUkDWOOITWShn9doJ75JBwcSlNgi30lDNSyfA01C0ByG3i
6dmhOy4ktGqUPmyJ7y9oezEZEvcEMAKW7tVnpvklp4ZaHhPrkGZ+6KXhAgMBAAEC
gYAT1ig2SwqSbbExqtDd3r7el5NbcZCoYeP/ffIr62Pn31o8L3aYxtkgkdCoUkPv
bZs0LYrvb29BeYGL4tNaC/Phe0/2SMnUUK+YyHuqycKVsa5yUBkJ2ce/JoKn+m7f
lebHNASS6wK+i5xfhRMgeYcpgpxquLnHEfEro+SoAetsGQJBAJ1ZrABdZdJpvp1D
yLmVGXLg+0bLolsR5l0DBzxv+hCSnbHaPUGeTB0YnnvzC5LZDnMfARjoeGi1t/gr
vDw40TsCQQCEmzzk66cQVMrC8HK6ogVUtdnETpZkN/q94fRtmS8dEpuI9UeseERh
duB8YfvaQ6HBK/rrpJMyJm6NRwGIMXOTAkAQh8wnGajJyywoT2e1/3D1/abIUDpV
QPMnkFrhQY5O0WhZt+i5jQzH/b8gnG751W3MMFSoLjwAHB8gpk+XMAzjAkABV/FO
AHU43SMQxo7jBTE4on8KViF/8nE/60Imuh6YFNAumw2W2cEXm7S6jeOXWogRBPkN
2iUDpRAJrmZ9ksKxAkBz4+ZHvv3IpHNLGjrDD2fz9HfwnoEJwUvuzbZcREEnwZwB
YBIo7Up8/iHNJVC3heL/H+4ejYfNJ+gGQenAsmoM
-----END RSA PRIVATE KEY-----

-----BEGIN PUBLIC KEY-----
MIGeMA0GCSqGSIb3DQEBAQUAA4GMADCBiAKBgFGBp2kNZlPJOxYeBbmQ0P6YQD/E
Gjmg/Tq+H/AKAzK9GsvdP3dXDfRMax71or5hLYPIpRNUkDWOOITWShn9doJ75JBw
cSlNgi30lDNSyfA01C0ByG3i6dmhOy4ktGqUPmyJ7y9oezEZEvcEMAKW7tVnpvkl
p4ZaHhPrkGZ+6KXhAgMBAAE=
-----END PUBLIC KEY-----

**Send an asymmetrically encrypted message to one of your peers via the public Slack channel. They should be able to decrypt the message using a key. The recipient should be able to read the message, but it should remain a secret to everyone else. You are not allowed to use any private messages or other communication channels besides the public Slack channel. Analyse the difference between this method and symmetric encryption.**

![Alt text](../00_includes/Week3/SEC-05.PNG)

This method is much safer because only the recipient of a message will be able to decrypt it because the private key will never be send. However by posting a public key I'm still only able to receive and decrypt messages. In order to be able to send and encrypt I need to use the public key if posted earlier by the receiver. This can get a bit cumbersome if you want to converse back and forth. One way to make this a bit easier is to encrypt a symmetric key in the initial messages so that the following messaging will be smoother and less time consuming.