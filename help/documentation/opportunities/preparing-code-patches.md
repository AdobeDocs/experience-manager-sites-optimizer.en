---
title: Preparing Code Patches Documentation
description: Learn how AEM Sites Optimizer prepares code patches for Core Web Vitals fixes and how to track them afterward.
product_v2:
  - id: fd1f54a9-f50c-467d-8956-cebbaf4f3eb8
    internal-label: Experience Manager
topic_v2:
  - id: cdd65e7e-8839-44a2-bc21-0e03623b5dd1
    internal-label: Optimization
---
# Preparing code patches documentation

<!--![Preparing code patches](./assets/preparing-code-patches/hero.png){align="center"}-->

For the [Core web vitals opportunity](/help/documentation/opportunities/core-web-vitals.md), AEM Sites Optimizer generates code-level fixes for identified performance issues. You review and prepare these fixes as code patches rather than deploying them directly.

## Prepare code patches

Select one or more issues from the Core Web Vitals list, then click **Prepare code patch** to prepare your selection, or **Prepare all code patches** to prepare every available patch at once. AEM Sites Optimizer creates a labeled GitHub issue for each fix and automatically opens a linked pull request with the code change, ready for your team to review, test, and merge.

This action is disabled when you don't have permission to prepare code patches, or when the site isn't fully configured for it — for example, when no code repository is connected, or patch generation is still in progress. In each case, Sites Optimizer explains why next to the disabled button.

## Track prepared code patches

Once you've prepared code patches, you can manage them and take next steps from the **Deployed** tab on the Core Web Vitals details page, alongside the **Current** and **Ignored** tabs. A patch's status there reflects whether its pull request has been merged, not just generated — an issue only moves to **Deployed** once the fix has actually been merged into your codebase.

## Also see

* [Core web vitals opportunity](/help/documentation/opportunities/core-web-vitals.md#auto-optimize)
* [Deploying to author documentation](/help/documentation/opportunities/deploying-to-author.md)
