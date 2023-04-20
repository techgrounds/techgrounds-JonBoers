# Passwords

Introduction:
In terms of factors of authentication, passwords fall into the ‘something you know’ category.
On the front-end, passwords can be guessed. This can be made harder with the following strategies:
Not using common passwords
Using longer passwords
Using special characters like @,*,%, etc.
Using a mixture of CAPITAL and small letters
Not using easily deducible passwords like birthdates or pet names
Using a different password for every login
Using a passphrase

Of course, these strategies make it harder to remember your own passwords. Password managers were created to solve this problem.
On the back-end, passwords need to be stored securely. If your database (or /etc/shadow file in Linux) gets leaked or stolen, you don’t want anyone to just be able to read passwords in plaintext. This is why most stored passwords are hashed. Hackers will try to use a Rainbow Table to crack hashed passwords.

Requirements:
Your Linux machine
A peer
An online Rainbow Table like https://crackstation.net/



## Key-terms
[Schrijf hier een lijst met belangrijke termen met eventueel een korte uitleg.]

## Opdracht
### Gebruikte bronnen
[Plaats hier de bronnen die je hebt gebruikt.]

### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat

Exercise:

Find out what hashing is and why it is preferred over symmetric encryption for storing passwords.
Find out how a Rainbow Table can be used to crack hashed passwords.
Below are two MD5 password hashes. One is a weak password, the other is a string of 16 randomly generated characters. Try to look up both hashes in a Rainbow Table.
03F6D7D1D9AAE7160C05F71CE485AD31
03D086C9B98F90D628F2D1BD84CFA6CA
Create a new user in Linux with the password 12345. Look up the hash in a Rainbow Table.
Despite the bad password, and the fact that Linux uses common hashing algorithms, you won’t get a match in the Rainbow Table. This is because the password is salted. To understand how salting works, find a peer who has the same password in /etc/shadow, and compare hashes.

