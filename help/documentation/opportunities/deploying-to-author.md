---
title: Deploying to Author
description: Learn how AEM Sites Optimizer deploys selected optimizations to your AEM Author instance and how to track them afterward.
product_v2:
  - id: fd1f54a9-f50c-467d-8956-cebbaf4f3eb8
    internal-label: Experience Manager
topic_v2:
  - id: cdd65e7e-8839-44a2-bc21-0e03623b5dd1
    internal-label: Optimization
---
# Deploying to Author

<!--![Deploying to Author](./assets/deploying-to-author/hero.png){align="center"}-->

After AEM Sites Optimizer identifies an opportunity and suggests optimizations, you can deploy the selected optimizations to your AEM Author instance for review.

## Deploy to Author

Select one or more suggestions from an opportunity's list, then click **Deploy to Author** (or **Deploy all to author**) to deploy them.

>[!NOTE]
>
>Deploying to Author applies the selected optimizations to the AEM Author instance only. It does not publish changes to your live site. This lets your team review the changes in Author before they publish, consistent with each opportunity's own [Auto-optimize](/help/documentation/opportunities/missing-alt-text.md#auto-optimize) workflow.

## Track deployed optimizations

<!--![Deployed tab](./assets/deploying-to-author/deployed-tab.png){align="center"}-->

Once you've deployed selected optimizations, you can manage them and take next steps from the **Deployed** tab on the opportunity's details page, alongside the **Current** and **Ignored** tabs.

The specific deployment mechanics — including how updates are applied for Edge Delivery Services, AEM as a Cloud Service, or Digital Asset Management — vary by opportunity type. See that opportunity's own **Auto-optimize** section for details.

## Also see

* [Missing alt text opportunity](/help/documentation/opportunities/missing-alt-text.md#auto-optimize)
* [Core web vitals opportunity](/help/documentation/opportunities/core-web-vitals.md#auto-optimize)
* [Broken backlinks opportunity](/help/documentation/opportunities/broken-backlinks.md#auto-optimize)
