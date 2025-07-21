---
title: Broken Backlinks Opportunity Documentation
description: Learn about the broken backlinks opportunity and how to use it to improve traffic acquisition.
badgeTrafficAcquisition: label="Traffic acquisition" type="Caution" url="../../opportunity-types/traffic-acquisition.md" tooltip="Traffic acquisition"
---

# Broken backlinks opportunity

![Broken backlinks opportunity](./assets/broken-backlinks/hero.png){align="center"}

The broken backlinks opportunity identifies links from other websites to your site that lead to a 404 error. Since search engines use backlinks to determine search relevance, broken links can negatively impact your site's SEO and discoverability. These issues can arise from factors such as URL changes or the removal of the linked page.

The broken backlinks opportunity displays a summary at the top of the page, including a synopsis of the problem and its impact on your site and business.

* **Projected traffic lost** - The estimated traffic loss due to broken backlinks.
* **Projected traffic value** - The estimated value of the lost traffic.

## Auto-identify

![Auto-identify broken backlinks](./assets/broken-backlinks/auto-identify.png){align="center"}

The broken backlinks opportunity lists out all the broken backlinks on your site, including the:

* **Referring page** - The website domain that contains the broken link.
* **Priority** - High, medium, or low, indicating the impact the broken link has on SEO based on TODO.
* **Broken target URL** - The non-existing URL on your site that is being linked to.

## Auto-suggest

![Auto-suggest broken backlinks](./assets/broken-backlinks/auto-suggest.png){align="center"}

The broken backlinks opportunity also provides an AI-generated suggestions on which page on your website the broken URL should redirect to. The suggestions are based on the text that comprises the broken URL, and the content of the suggested page.


>[!BEGINTABS]

>[!TAB AI rationale]

![AI rationale on autosuggestion of broken backlinks](./assets/broken-backlinks/auto-suggest-ai-rationale.png){align="center"}

Select the **information** icon to view the AI rationale for the suggested URL. The rationale explains why the AI believes the suggested URL is the best fit for the broken link. It can help you understand the AI's decision-making process and make an informed decision on whether to accept or reject the suggestion.

>[!TAB Edit target URL]

![Edit suggested URL of broken backlinks](./assets/broken-backlinks/edit-target-url.png){align="center"}

If you disagree with the AI-generated suggestion, you can edit the suggested URL by selecting the **edit icon**. Editing lets you manually input the URL you believe is the best fit for the broken link. Sites Optimizer also lists any other URLs on your site that it believes may be a good fit for the broken link.  

>[!TAB Ignore entries]

![Ignore broken backlinks](./assets/broken-backlinks/ignore.png){align="center"}

You can choose to ignore entires with the broken target URL. Selecting ![Delete icon or ignore icon](https://spectrum.adobe.com/static/icons/ui_18/CrossSize500.svg) removes the broken backlink from the opportunity list. Ignored broken backlinks can be re-engaged from the **Ignored** tab at the top of the opportunity page.

>[!ENDTABS]

## Auto-optimize

[!BADGE Ultimate]{type=Positive tooltip="Ultimate"}

![Auto-optimize broken backlinks](./assets/broken-backlinks/auto-optimize.png){align="center"}

Sites Optimizer Ultimate adds the ability to deploy auto-optimization for broken backlinks. Selecting the **Auto-optimize** button automatically updates the AEM Site's redirect rules to map the **broken target URL** to the **suggested URL**. This functionality ensures that website visitors and search bots following the broken links on the **referring pages** are redirected to the correct page on your site, improving SEO and user experience.

>[!BEGINTABS]

>[!TAB Deploy optimization]

![Deploy optimization of broken backlinks](./assets/broken-backlinks/deploy-optimization.png){align="center"}

Selecting **Deploy optimization** updates the AEM Site's redirect rules to map the **broken target URL** to the **suggested URL**. This functionality ensures that website visitors and search bots following the broken links on the **referring pages** are redirected to the correct page on your site, improving SEO and user experience.

>[!TAB Request approval]

![Request approval of broken backlinks](./assets/broken-backlinks/request-approval.png){align="center"}

{{auto-optimize-request-approval}}

>[!ENDTABS]
