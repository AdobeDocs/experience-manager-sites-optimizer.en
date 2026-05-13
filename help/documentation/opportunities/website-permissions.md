---
title: Website Permissions Opportunity Documentation
description: Learn about the website permissions opportunity and how to use it to increase the security of on your website.
badgeSecurityPosture: label="Security posture" type="Caution" url="../../opportunity-types/security-posture.md" tooltip="Security posture"
TQID: https://experienceleague.adobe.com/9nGa4iRd0cBuWSUZxLvbXXo1Rx84ZqMLnD8lF8XkayU
product_v2:
  - id: fd1f54a9-f50c-467d-8956-cebbaf4f3eb8
    internal-label: Experience Manager
topic_v2:
  - id: cdd65e7e-8839-44a2-bc21-0e03623b5dd1
    internal-label: Optimization
  - id: d095671a-1355-40aa-8b5f-06c33c68080b
    internal-label: Security
---
# Website permissions opportunity

![Website permissions opportunity](./assets/website-permissions/hero.png){align="center"}

The website permissions opportunity optimizes website permissions, crucial for maintaining a secure and manageable AEM environment. This opportunity allows you to refine access controls by removing overly broad permissions - such as `jcr:all` on generic paths like `/` or `/content` — and aligning user access with the principle of least privilege. By streamlining permissions and eliminating redundancies, you can reduce security risks, improve maintainability, and prevent future misconfigurations. Review and update permissions in the AEM Security Permissions console or in your code repository. Doing so ensures that service users have only the access they truly need.

## Auto-identify

![Auto-identify website permissions](./assets/website-permissions/auto-identify.png){align="center"}

The **Website Permissions opportunity** feature automatically identifies and lists 

* **User** – The user account with the suspect permission.
* **Path** – Use the tabs across the top to organize and filter opportunities by status.
* **Permission** – The suspected permission.
* **Issue** - Indicates the type of issue impacting the permission.

## Auto-suggest

![Auto-suggest website vulnerabilities](./assets/website-permissions/auto-suggest.png){align="center"}

Auto-suggest provides AI-generated recommendations in the **Suggested permissions** field, allowing you to replace any flagged permissions with secure alternatives.

## Auto-optimize

[!BADGE Ultimate]{type=Positive tooltip="Ultimate"}

![Auto-optimize website permissions](./assets/website-permissions/auto-optimize.png){align="center"}

Sites Optimizer Ultimate adds the ability to deploy auto-optimization for the vulnerabilities found.

>[!BEGINTABS]

>[!TAB Deploy optimization]

{{auto-optimize-deploy-optimization-slack}}

>[!TAB Request approval]

{{auto-optimize-request-approval}}

>[!ENDTABS]
