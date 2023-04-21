# Detection, response and analysis

Introduction:
So far, we’ve mostly looked at the prevention of attacks. While you want to prevent as many attacks as possible, some attacks will slip through your prevention systems. The most common method of getting malicious software (malware) into a network is through social engineering.

When getting hit with an attack, there are usually three steps to follow: Detection, response, and analysis.

Detecting an (attempted) attack is the first step to stopping it and to preventing future attempts. Tools like Wireshark can help analyse a network to detect anomalies. Intrusion detection systems (IDS) and intrusion prevention systems (IPS) are also used for this purpose.

The first thing to do in response to a detected attack is trying to contain the damage. Depending on the kind of attack, the way you do this might differ. After the attack is contained, you can try to figure out the root cause of the attack, so that you can stop it. Finally, you enter the recovery phase, where you try to get all systems back online and you take stock of the damage done.

It is vitally important to have a plan in place for how to respond when an attack happens.
In the analysis phase, you document what you learned and harden your systems so that such an attack cannot happen again. Sometimes this can be as simple as updating the OS on a server.

Response, and analysis are part of a disaster recovery plan. This plan is an important part of a bigger business continuity plan. When a disaster strikes and infrastructure goes offline, a business could be done for. There are many strategies when it comes to mitigating a disaster. From just having a cold backup, to a redundant site.
For these strategies it is always important to keep track of the following metrics: How much data is lost on incident (Recovery Point Objective; RPO), how long it takes to be back online (Recovery Time Objective; RTO), and cost.

Study:
IDS and IPS.  
Hack response strategies.  
The concept of systems hardening.  
Different types of disaster recovery options.

## Key-terms

IDS: An Intrusion Detection System is a monitoring system that detects suspicious activities and generates alerts when they are detected. Based upon these alerts, a security operations center (SOC) analyst or incident responder can investigate the issue and take the appropriate actions to remediate the threat.

IPS: An Intrusion Prevention System works by actively scanning forwarded network traffic for malicious activities and known attack patterns. The IPS engine analyzes network traffic and continuously compares the bitstream with its internal signature database for known attack patterns.

NGFW: Next generation Firewall
In addition to access control, NGFWs can block modern threats such as advanced malware and application-layer attacks. According to Gartner's definition, a next-generation firewall must include:

* Standard firewall capabilities like stateful inspection  
* Integrated intrusion prevention
* Application awareness and control to see and block risky apps
* Threat intelligence sources
* Upgrade paths to include future information feeds
* Techniques to address evolving security threats

<details>
<summary>This Article describes IDS versus IPS and Next Generation Firewalls (click):</summary>  

### Classification of Intrusion Detection Systems
Intrusion detection systems are designed to be deployed in different environments. And like many cybersecurity solutions, an IDS can either be host-based or network-based. 

**Host-Based IDS (HIDS):** A host-based IDS is deployed on a particular endpoint and designed to protect it against internal and external threats. Such an IDS may have the ability to monitor network traffic to and from the machine, observe running processes, and inspect the system’s logs. A host-based IDS’s visibility is limited to its host machine, decreasing the available context for decision-making, but has deep visibility into the host computer’s internals.  

**Network-Based IDS (NIDS):** A network-based IDS solution is designed to monitor an entire protected network. It has visibility into all traffic flowing through the network and makes determinations based upon packet metadata and contents. This wider viewpoint provides more context and the ability to detect widespread threats; however, these systems lack visibility into the internals of the endpoints that they protect.

Due to the different levels of visibility, deploying a HIDS or NIDS in isolation provides incomplete protection to an organization’s system. A unified threat management solution, which integrates multiple technologies in one system, can provide more comprehensive security.

### Detection Method of IDS Deployment
Beyond their deployment location, IDS solutions also differ in how they identify potential intrusions:

*Signature Detection:* Signature-based IDS solutions use fingerprints of known threats to identify them. Once malware or other malicious content has been identified, a signature is generated and added to the list used by the IDS solution to test incoming content. This enables an IDS to achieve a high threat detection rate with no false positives because all alerts are generated based upon detection of known-malicious content. However, a signature-based IDS is limited to detecting known threats and is blind to zero-day vulnerabilities.

*Anomaly Detection:* Anomaly-based IDS solutions build a model of the “normal” behavior of the protected system. All future behavior is compared to this model, and any anomalies are labeled as potential threats and generate alerts. While this approach can detect novel or zero-day threats, the difficulty of building an accurate model of “normal” behavior means that these systems must balance false positives (incorrect alerts) with false negatives (missed detections).

*Hybrid Detection:* A hybrid IDS uses both signature-based and anomaly-based detection. This enables it to detect more potential attacks with a lower error rate than using either system in isolation.

### IDS vs Firewalls
Intrusion Detection Systems and firewalls are both cybersecurity solutions that can be deployed to protect an endpoint or network. However, they differ significantly in their purposes.

An IDS is a passive monitoring device that detects potential threats and generates alerts, enabling security operations center (SOC) analysts or incident responders to investigate and respond to the potential incident. An IDS provides no actual protection to the endpoint or network. A firewall, on the other hand, is designed to act as a protective system. It performs analysis of the metadata of network packets and allows or blocks traffic based upon predefined rules. This creates a boundary over which certain types of traffic or protocols cannot pass.

Since a firewall is an active protective device, it is more like an Intrusion Prevention System (IPS) than an IDS. An IPS is like an IDS but actively blocks identified threats instead of simply raising an alert. This complements the functionality of a firewall, and many next-generation firewalls (NGFWs) have integrated IDS/IPS functionality. This enables them to both enforce the predefined filtering rules (firewalls) and detect and respond to more sophisticated cyber threats (IDS/IPS). 

### Selecting an IDS Solution
An IDS is a valuable component of any organization’s cybersecurity deployment. A simple firewall provides the foundation for network security, but many advanced threats can slip past it. An IDS adds an additional line of defense, making it more difficult for an attacker to gain access to an organization’s network undetected.

When selecting an IDS solution, it is important to carefully consider the deployment scenario. In some cases, an IDS may be the best choice for the job, while, in others, the integrated protection of an IPS may be a better option. Using a NGFW that has built-in IDS/IPS functionality provides an integrated solution, simplifying threat detection and security management.
</details>


RTO: Recovery Time Objective is the goal an organization sets for the maximum length of time it should take to restore normal operations following an outage or data loss.
RPO: Recovery Point Objective is the goal for the maximum amount of data the organization can tolerate losing. This parameter is measured in time: from the moment a failure occurs to your last valid data backup. For example, if you experience a failure now and your last full data backup was 24 hours ago, the RPO is 24 hours

<details>
<summary>hack response strategies (click): </summary>

1. Follow a communication plan.
Figuring out who to inform after a hacking attack is critical. What does the attack mean? Who should you tell? How do you tell them? When do you tell them? Implement a communication plan before the hacking attack occurs to carry it out once the attack takes place. 

2. Secure IT systems.
As soon as you realize the breach, secure your IT systems to limit the scope of the attack. 

3. Launch backups.
Hopefully, you’ve developed a good crash plan for your website. Now is the time to launch that crash plan and deploy your backups to protect your data from further harm. 

4. Notify authorities.
Let the authorities know about the cyber attack on your organization. This will help protect your customers and make a record of the attack so that authorities can respond. 

5. Create redundancy in your data.
This is a critical part of data security and protecting your assets. Data redundancy is a condition created within a database or data storage technology where the same piece of data is held in two separate places.

</details>  



## Opdracht
### Gebruikte bronnen
https://www.checkpoint.com/cyber-hub/network-security/what-is-an-intrusion-detection-system-ids/#:~:text=An%20Intrusion%20Detection%20System%20(IDS)%20is%20a%20monitoring%20system%20that,actions%20to%20remediate%20the%20threat  
https://www.exabeam.com/incident-response/cyber-attribution-essential-component-of-incident-response-or-optional-extra/  
https://www.rubrik.com/insights/rto-rpo-whats-the-difference#:~:text=These%20are%20the%20Recovery%20Time,the%20organization%20can%20tolerate%20losing    
https://securityboulevard.com/2019/11/5-tips-for-responding-to-cyber-attacks/

### Ervaren problemen

### Resultaat

**Exercise:**  

**A Company makes daily backups of their database. The database is automatically recovered when a failure happens using the most recent available backup. The recovery happens on a different physical machine than the original database, and the entire process takes about 15 minutes. What is the RPO of the database?**  

Since RPO is defined in time "from the moment a failure occurs to your last valid data backup" and there's a 'daily backup' the RPO is 24 hours.

**An automatic failover to a backup web server has been configured for a website. Because the backup has to be powered on first and has to pull the newest version of the website from GitHub, the process takes about 8 minutes. What is the RTO of the website?**

Since RTO is defined as the "maximum length of time it should take to restore normal operations following an outage or data loss" the RTO is likely to be 8 minutes in reality, although it's not sure whether this was the set objective. It might be slower or faster as intended, but this is just symantics.
