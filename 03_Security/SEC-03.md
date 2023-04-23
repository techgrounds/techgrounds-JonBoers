# Identity and Access Management

Introduction:
Security goes in two steps: authentication and authorization. Both are two different actions that happen whenever you log in.

Multi-factor authentication (MFA) is a common way to improve security.
It is best practice to follow the principle of least privilege for authorization.

Study:
The difference between authentication and authorization.
The three factors of authentication and how MFA improves security.
What the principle of least privilege is and how it improves security.

## Key-terms

Authentication: verifies the identity of a user or service  
Authorization: the security process that determines a user or service's level of access  
The three factors of authentication: something you know, something you have, something you are.  
MFA: Multi-factor authentication a combination of the above adds another layer if one of the factors is stolen or breached.  
Access Control Lists (ACLs): determine which users or services can access a particular digital environment.  
Least privilege: (PoLP) is an information security concept which maintains that a user or entity should only have access to the specific data, resources and applications needed to complete a required task.


## Opdracht
### Gebruikte bronnen

https://www.onelogin.com/learn/authentication-vs-authorization#:~:text=Authentication%20and%20authorization%20are%20two,authorization%20determines%20their%20access%20rights  
https://www.paloaltonetworks.com/cyberpedia/what-is-the-principle-of-least-privilege#:~:text=The%20principle%20of%20least%20privilege%20(PoLP)%20is%20an%20information%20security,to%20complete%20a%20required%20task.


### Ervaren problemen

### Resultaat

**Authentication and authorization** are two vital information security processes that administrators use to protect systems and information. Authentication verifies the identity of a user or service, and authorization determines their access rights. Although the two terms sound alike, they play separate but equally essential roles in securing applications and data. Understanding the difference is crucial. Combined, they determine the security of a system. You cannot have a secure solution unless you have configured both authentication and authorization correctly.

*What is Authentication (AuthN)?*
Authentication (AuthN) is a process that verifies that someone or something is who they say they are. Technology systems typically use some form of authentication to secure access to an application or its data. For example, when you need to access an online site or service, you usually have to enter your username and password. Then, behind the scenes, it compares the username and password you entered with a record it has on its database. If the information you submitted matches, the system assumes you are a valid user and grants you access. System authentication in this example presumes that only you would know the correct username and password. It, therefore, authenticates you by using the principle of something only you would know.  
*What is the Purpose of Authentication?*
The purpose of authentication is to verify that someone or something is who or what they claim to be. There are many forms of authentication. For example, the art world has processes and institutions that confirm a painting or sculpture is the work of a particular artist. Likewise, governments use different authentication techniques to protect their currency from counterfeiting. Typically, authentication protects items of value, and in the information age, it protects systems and data.
What is Identity Authentication?
Identity authentication is the process of verifying the identity of a user or service. Based on this information, a system then provides the user with the appropriate access. For example, let's say we have two people working in a coffee shop, Lucia and Rahul. Lucia is the coffee shop manager while Rahul is the barista. The coffee shop uses a Point of Sale (POS) system where waiters and baristas can place orders for preparation. In this example, the POS would use some process to verify Lucia or Rahul's identity before allowing them access to the system. For instance, it may ask them for a username and password, or they may need to scan their thumb on a fingerprint reader. As the coffee shop needs to secure access to its POS, employees using the system need to verify their identity via an authentication process.

Common Types of Authentication
Systems can use several mechanisms to authenticate a user. Typically, to verify your identity, authentication processes use: - something you know - something you have - or something you are

Passwords and security questions are two authentication factors that fall under the something-you-know category. As only you would know your password or the answer to a particular set of security questions, systems use this assumption to grant you access.

Another common type of authentication factor uses something you have. Physical devices such as USB security tokens and mobile phones fall under this category. For example, when you access a system, and it sends you a One Time Pin (OTP) via SMS or an app, it can verify your identity because it is your device.

The last type of authentication factor uses something you are. Biometric authentication mechanisms fall under this category. Since individual physical characteristics such as fingerprints are unique, verifying individuals by using these factors is a secure authentication mechanism.

What is Authorization (AuthZ)?  

Authorization is the security process that determines a user or service's level of access. In technology, we use authorization to give users or services permission to access some data or perform a particular action. If we revisit our coffee shop example, Rahul and Lucia have different roles in the coffee shop. As Rahul is a barista, he may only place and view orders. Lucia, on the other hand, in her role as manager, may also have access to the daily sales totals. Since Rahul and Lucia have different jobs in the coffee shop, the system would use their verified identity to provide each user with individual permissions. It is vital to note the difference here between authentication and authorization. Authentication verifies the user (Lucia) before allowing them access, and authorization determines what they can do once the system has granted them access (view sales information).
Common Types of Authorization
Authorization systems exist in many forms in a typical technology environment. For example, Access Control Lists (ACLs) determine which users or services can access a particular digital environment. They accomplish this access control by enforcing allow or deny rules based on the user's authorization level. For instance, on any system, there are usually general users and super users or administrators. If a standard user wants to make changes that affect its security, an ACL may deny access. On the other hand, administrators have the authorization to make security changes, so the ACL will allow them to do so.

Another common type of authorization is access to data. In any enterprise environment, you typically have data with different levels of sensitivity. For example, you may have public data that you find on the company's website, internal data that is only accessible to employees, and confidential data that only a handful of individuals can access. In this example, authorization determines which users can access the various information types.

The Difference Between Authentication and Authorization
As mentioned, authentication and authorization may sound alike, but each plays a different role in securing systems and data. Unfortunately, people often use both terms interchangeably as they both refer to system access. However, they are distinct processes. Simply put, one verifies the identity of a user or service before granting them access, while the other determines what they can do once they have access.

The best way to illustrate the differences between the two terms is with a simple example. Let's say you decide to go and visit a friend's home. On arrival, you knock on the door, and your friend opens it. She recognizes you (authentication) and greets you. As your friend has authenticated you, she is now comfortable letting you into her home. However, based on your relationship, there are certain things you can do and others you cannot (authorization). For example, you may enter the kitchen area, but you cannot go into her private office. In other words, you have the authorization to enter the kitchen, but access to her private office is prohibited.

What are the Similarities Between Authorization and Authentication?
Authentication and authorization are similar in that they are two parts of the underlying process that provides access. Consequently, the two terms are often confused in information security as they share the same "auth" abbreviation. Authentication and authorization are also similar in the way they both leverage identity. For example, one verifies an identity before granting access, while the other uses this verified identity to control access.
Authentication and Authorization in Cloud Computing
Security is a vital component in any cloud computing solution. As these services provide a shared access model where everything runs on the same platform, they need to separate and protect customer systems and data. Cloud service providers use authentication and authorization to achieve these security goals. In fact, cloud computing platforms could not provide economies of scale via their shared resourcing model without authentication and authorization.

For example, when a user tries to access a particular cloud service, the system will prompt them for some form of authentication. This challenge could ask them to enter a username and password or use another identity verification factor, such as accepting a notification on an app. Once the user successfully authenticates, the cloud platform will then use authorization to ensure the user can only access their systems and data. Without authentication and authorization, the separation of customer environments on the same platform would not be possible.

Which Comes First, Authentication or Authorization?
Authentication and authorization both rely on identity. As you cannot authorize a user or service before identifying them, authentication always comes before authorization. Again, we can refer back to our coffee shop example to illustrate this point.

As mentioned, baristas can only create and view orders, while managers can also access daily sales data. If the POS system cannot identify which user is accessing the system, it cannot provide the correct level of access. Authentication provides the verified identity authorization needs to control access. When Rahul or Lucia sign into the system, the application knows who has signed in and what role it should assign to their identity.

Access control vs. Authentication?
People often use the terms access control and authorization interchangeably. Although many authorization policies form part of access control, access control is a component of authorization. Access control uses the authorization process to either grant or deny access to systems or data. In other words, authorization defines policies on what a user or service may access. Access control enforces these policies.

If we compare authentication and access control, the comparison between authentication and authorization still applies. Authentication verifies the user's identity, and access control uses this identity to grant or deny access.

**The principle of least privilege (PoLP)** is an information security concept which maintains that a user or entity should only have access to the specific data, resources and applications needed to complete a required task. Organizations that follow the principle of least privilege can improve their security posture by significantly reducing their attack surface and risk of malware spread.

The principle of least privilege is also a fundamental pillar of zero trust network access (ZTNA) 2.0. Within a ZTNA 2.0 framework, the principle of least privilege provides the ability to accurately identify applications and specific application functions across any and all ports and protocols, including dynamic ports, regardless of the IP address or fully qualified domain name (FQDN) an application uses. The principle of least privilege within ZTNA 2.0 eliminates the need for administrators to think about network constructs and enables fine-grained access control to implement comprehensive least-privileged access.

How does the principle of least privilege (PoLP) work?
The principle of least privilege works by limiting the accessible data, resources, applications and application functions to only that which a user or entity requires to execute their specific task or workflow. Without incorporating the principle of least privilege, organizations create over-privileged users or entities that increase the potential for breaches and misuse of critical systems and data.

Within ZTNA 2.0, the principle of least privilege means the information technology system can dynamically identify users, devices, applications and application functions a user or entity accesses, regardless of the IP address, protocol or port an application uses. This includes modern communication and collaboration applications that use dynamic ports.

The principle of least privilege as executed within ZTNA 2.0 eliminates the need for administrators to think about the network architecture or low-level network constructs such as FQDN, ports or protocols, enabling fine-grained access control for comprehensive least-privileged access.

Why Is the Principle of Least Privilege Important?
The principle of least privilege is an important information security construct for organizations operating in today’s hybrid workplace to help protect them from cyberattacks and the financial, data and reputational losses that follow when ransomware, malware and other malicious threats impact their operations.

The principle of least privilege strikes a balance between usability and security to safeguard critical data and systems by minimizing the attack surface, limiting cyberattacks, enhancing operational performance and reducing the impact of human error.

What Are the Benefits of the Principle of Least Privilege?

The principle of least privilege;  
Minimizes the attack surface, diminishing avenues a malicious actor can use to access sensitive data or carry out an attack by protecting superuser and administrator privileges.
Reduces malware propagation by not allowing users to install unauthorized applications. The principle of least privilege also stops lateral network movement that can launch an attack against other connected devices by limiting malware to the entry point.
Improves operational performance with reductions in system downtime that might otherwise occur as a result of a breach, malware spread or incompatibility issues between applications.
Safeguards against human error that can happen through mistake, malice or negligence.

*The benefits of PoLP for modern applications*  
The principle of least privilege is all about providing the minimum amount of privilege possible for users to get their work done. Unfortunately, legacy security solutions require organizations to allow access to a broad range of IP addresses, port ranges and protocols in order to use SaaS and other modern apps that use dynamic IPs and ports. This approach violates the principle of least privilege, creating a huge security gap that can be exploited by an attacker or malware.

ZTNA 2.0 enables comprehensive usage of the principle of least privilege with Prisma Access and its patented App-ID functionality to provide dynamic identification of all users, devices and applications as well as application functions across any and all protocols and ports. For administrators, this enables very fine-grained access control to finally implement true least-privileged access.

The Benefits of PoLP for Client-Server Applications
Comprehensive principle of least privilege technologies – like those available in Prisma Access – enable bidirectional access control between a client and server to define application access policies and easily enable least-privileged access for applications that use server-initiated connections. This includes mission-critical applications such as update and patch management solutions, device management applications and help desk applications.

The Benefits of PoLP for Private Applications
Many private applications lack the built-in, fine-grained access control capabilities that exist in most modern SaaS apps. Something as simple as allowing users to access an application to view – but not upload or download – data is simply not possible because the application is identified purely based on IP address and port number.

With the PoLP capabilities available through ZTNA 2.0 and Prisma Access, organizations get granular control at the sub-app level, enabling them to identify applications at the App-ID level.

How to Implement PoLP in your organization
Implementing the principle of least privilege within your organization should not be difficult, overwhelming or come with compromises. It boils down to alignment – mapping needs to the key concerns or challenges without requiring a massive architectural shift or business disruption. 

Where to Start a PoLP Implementation
VPN technology replacement is a good starting point for implementing the principle of least privilege within your organization. Replace legacy remote access outdated VPN technologies with a more modern ZTNA 2.0 solution to overcome performance bottlenecks and simplify management. 

VPN replacement initiatives are driven by a number of factors: 

Applications moving to a true hybrid model, taking advantage of on-premises, cloud and multicloud environments. Legacy VPN technology that trombones or backhauls traffic to an on-premises “concentrator” doesn’t scale or deliver the best possible user experience in this new model.
Changes in enterprise app access requirements. Traditionally, employees used managed devices to complete work-related tasks. However, more and more unmanaged devices have made their way onto corporate networks and can access corporate applications.
Organizations looking for consistent and universal protection and a security model for all apps, not just web or legacy applications.