---
title: Cross-site Scripting Opportunity Documentation
description: Learn about the cross-site scripting opportunity and to identify and fix site security vulnerabilities.
badgeSecurityPosture: label="Security posture" type="Caution" url="../../opportunity-types/security-posture.md" tooltip="Security posture"
TQID: https://experienceleague.adobe.com/8ZpnC3XTmcz1uPeyJM0UqR97PfvekI3QHGf6xDT5Tcc
product_v2:
  - id: fd1f54a9-f50c-467d-8956-cebbaf4f3eb8
    internal-label: Experience Manager
topic_v2:
  - id: cdd65e7e-8839-44a2-bc21-0e03623b5dd1
    internal-label: Optimization
  - id: d095671a-1355-40aa-8b5f-06c33c68080b
    internal-label: Security
---
# Cross-site scripting opportunity

![Cross-site opportunity](./assets/cross-site-scripting/hero.png){align="center"}

The cross-site scripting opportunity identifies vulnerabilities in your site's code. It then fixes issues that attackers could exploit to inject malicious scripts into web pages viewed by other users. These scripts can steal sensitive information, such as session cookies, or perform actions on behalf of the user, such as changing the user's password.

## Auto-identify

![Auto-identify Cross-site opportunity](./assets/cross-site-scripting/auto-identify.png){align="center"} 

* **Vulnerable code** - Any code that is vulnerable to cross-site scripting attacks.
* **Link to reproduce** - The link to the page where the vulnerability was found.

## Auto-suggest

![Auto-suggest Cross-site opportunity](./assets/cross-site-scripting/auto-suggest.png){align="center"}

* **Suggested fix** - An AI-generated suggestion on how to fix the vulnerability.

## Auto-optimize

[!BADGE Ultimate]{type=Positive tooltip="Ultimate"}

>[!BEGINTABS]

>[!TAB Deploy optimization]

{{auto-optimize-deploy-optimization-slack}}

>[!TAB Request approval]

{{auto-optimize-request-approval}}

>[!ENDTABS]
