---
solution: Experience Manager
product: adobe experience manager
type: Documentation
description: AEM Sites Optimizer documentation.
index: y
git-repo: https://github.com/AdobeDocs/experience-manager-sites-optimizer.en
feature-set: Experience Manager Assets,Experience Manager Sites,Experience Manager, Experience Manager Forms, Experience Manager Cloud Manager
cloud: Experience Cloud
recommendations: noDisplay
---

# Metadata for internal use

The GitHub authoring system organizes metadata hierarchically, using the following increasing levels of precedent.

1. metadata.md
1. ToC
1. Article

The metadata defined in the metadata.md file apply to the entire repo, but can be overridden at the ToC and article levels. Any overriding of the metadata should be done at the lowest level possible.

The metadata in the `experience-manager-cloud-service.en` repo is the minimum required.

metadata.md

* `product`
* `git-repo`
* `index`
* `solution-title`
* `solution-hub-url`
* `getting-started-title`
* `getting-started-url`
* `tutorials-title`
* `tutorials-url`

ToCs

* `sub-product`
* `user-guide-title`

Article

* `title`
* `description`
* `contentOwner` (only on core asset content under `/help/assets`)

