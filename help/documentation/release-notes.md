---
title: Release Notes
description: Learn about the latest new features, improvements, and bug fixes in Adobe Experience Manager Sites Optimizer.
product_v2:
  - id: fd1f54a9-f50c-467d-8956-cebbaf4f3eb8
    internal-label: Experience Manager
topic_v2:
  - id: cdd65e7e-8839-44a2-bc21-0e03623b5dd1
    internal-label: Optimization
---

# Release Notes

This page documents the latest updates, new features, and improvements in Adobe Experience Manager Sites Optimizer. Releases follow a roughly two-week cadence.

---

## May 11–22, 2026

### New Features

- **Site Alerts Report** — A new 90-day Site Alerts Report provides a quarterly view of your site's health, using color-coded daily blocks to highlight periods of elevated alerts so you can quickly identify and investigate trends over time.
- **Operational Telemetry Onboarding** — Sites that have not yet connected operational telemetry data now receive a persistent banner on the home page and a guided onboarding dialog to complete setup, ensuring you get full visibility into real-user performance.
- **Alt Text: Multi-Site Manager Awareness** — When generating Alt Text fixes for sites that use AEM Multi-Site Manager or Language Copy, Sites Optimizer now checks whether fixes can be safely applied to each language variant before suggesting them.

### Enhancements

- **Alt Text Accuracy** — Alt Text suggestions now draw from the most recent audit signal, and re-detected issues are surfaced in both the Current Issues and Deployed tabs for a complete picture.

### Bug Fixes

- The Deploy button state now correctly reflects whether a fix can actually be deployed.
- Dark theme is now correctly applied on page refresh.
- Reports show dates in the user's locale.
- Regional preferences for language and number/date format can now be configured independently.
- Broken image alt text is now accessible to screen readers.

---

## April 21–May 10, 2026

### New Features

- **No Site Onboarded State** — Customers who have not yet added a site now see a clear, actionable prompt on the home page to get started quickly.
- **Documentation in Help Center** — The AEM Sites Optimizer documentation on Experience League is now accessible directly from the in-app help center, without leaving the product.

### Bug Fixes

- Sites with no active suggestions now correctly display an Action Required dialog.
- Skipped suggestions now appear in the Ignored tab as expected.
- Paid Traffic picker dropdowns no longer truncate translated text.
- Sitemap page picker is now correctly sized.

---

## March 13–April 20, 2026

### New Features

- **Trials Onboarding** — New trial users now experience a guided setup flow: enter your domain, wait for analysis, then explore your first opportunities — no configuration required to get started.
- **Trial Opportunities Page** — Trial users can search, sort, and filter opportunities, with three suggestions unlocked and remaining suggestions shown in a locked preview with an upgrade prompt.
- **Monthly Optimization Progress** — A progress bar on the home page tracks how many optimization actions you have taken this month, helping you stay on top of your site health goals.
- **Audit Target URLs** — Under Settings, you can now specify up to 100 custom URLs to ensure those pages are always included in audits.
- **Delivery Type Configuration** — Settings now lets you specify your site's delivery type (Edge Delivery Services, AEM Cloud Service, or AEM Managed Services) and connect your content provider.
- **Core Web Vitals Redesign** — The Core Web Vitals opportunity has been redesigned with Jira linking, CSV download, and multi-select support for batch actions.
- **Broken Backlinks Unified Table** — Broken backlinks from all sources are now shown in a single unified table, with the ability to export CDN redirect rules directly.
- **No CTA Above the Fold: Deploy to Author** — Fixes for the No CTA Above the Fold opportunity can now be deployed directly to AEM Author.
- **Forms Autofix Deploy** — Forms opportunity fixes can now be deployed directly to AEM Author.
- **AEM Multi-Site Manager Support** — Opportunities that affect multiple language copies of a site now indicate which root site the fix was applied at, using a "Fixed at" column.
- **Skip Failed Fixes** — You can now skip individual fixes that have failed deployment, keeping your workflow unblocked.
- **Open in AEM Editor** — Opportunity suggestions now include a direct link to open the affected page in AEM's visual editor for quick inline edits.

---

## February 28–March 13, 2026

### New Features

- **Ad Intent Mismatch Opportunity** — A new opportunity type identifies paid traffic landing pages that are not converting, surfacing bounce rate, cost-per-click, and traffic metrics to help you prioritize landing page improvements.
- **No CTA Above the Fold** — This opportunity is now a dedicated first-class type with its own detail page and filtering, making it easier to track and prioritize conversion improvements.
- **Sitemap URL Suggestions** — The Sitemap opportunity now suggests replacement URLs for pages returning 404 errors, making it easier to correct broken sitemap entries.
- **Redesigned Broken Backlinks** — The Broken Backlinks detail page has been redesigned for improved clarity and usability.

### Enhancements

- **Top Organic Search Pages V2** — Organic traffic data is now sourced from a 30-day Ahrefs dataset, providing more comprehensive and actionable search performance insights.
- **Security Vulnerabilities: Dependency Tree** — Security vulnerability details now include a dependency tree visualization so you can understand the full impact of a vulnerability across your project.

---

## February 14–27, 2026

### New Features

- **Top Organic Search Pages** — Site Health Monitor now includes a dedicated tab showing your site's top organic traffic pages, giving you visibility into which content drives the most search traffic.
- **Alt Text Autofix V2** — Before deploying an Alt Text fix, you can run a pre-flight "Check Fixability" assessment to verify the fix can be successfully applied to your content.
- **Deployed View for Alt Text** — Alt Text fixes now appear in a Deployed tab, giving you a full history of accessibility improvements alongside the current outstanding issues.
- **External Organization Deploy Gate** — When deploying fixes to an externally managed site, an explicit confirmation step is now required to prevent accidental changes.

### Enhancements

- **Meta Tags URL Exemptions** — Specific URLs can now be excluded from Meta Tags validation via configuration, reducing false positives for intentionally short or non-standard titles.
- **Advanced URL Filtering** — Opportunity lists now support sub-route prefix matching when filtering by URL, making it easier to focus on specific sections of your site.
- **Improved Trend Charts** — Traffic trend charts now handle year-over-year data correctly, removing misleading dips at year boundaries.

---

## February 6–13, 2026

### New Features

- **Maintenance Mode** — Sites Optimizer now handles planned maintenance windows gracefully, displaying a clear status message instead of incomplete or misleading data during downtime.
- **Deployed View for Broken Backlinks** — Fixed backlinks are now tracked in a Deployed tab, grouped by date so you can see your remediation history at a glance.
- **No CTA Above the Fold Opportunity** — A new opportunity type surfaces pages where no clear call-to-action is visible above the fold, helping you identify and improve pages with low conversion potential.
- **Jira Integration for Accessibility & Color Contrast** — Forms and Color Contrast accessibility opportunities can now be linked directly to Jira tickets for streamlined issue tracking within your existing workflow.

### Enhancements

- **Deployed Views for Meta Tags & Security** — Meta Tags and Security opportunities now include date-grouped Deployed tabs, consistent with other opportunity types.
- **Alt Text Deployment Tracking** — "Mark as Deployed" is now available for Alt Text fixes, and manually edited alt text is preserved across re-analysis runs.

---

## January 26–February 6, 2026

### New Features

- **Deployed View for Canonical & Hreflang** — Changes to Canonical and Hreflang opportunities are now grouped by deployment date in a Deployed tab, giving you a clear history of what was fixed and when.
- **CSV Export** — You can now export opportunity data for High Organic Low CTR and Forms opportunities to CSV for offline analysis and reporting.
- **Favorite Opportunities** — Star any opportunity from its header to add it to your favorites, making it faster to navigate back to the opportunities you are actively working on.
- **Deployed View for Redirect Chains** — Redirect Chain fixes can now be marked as Deployed directly from the details page.

### Enhancements

- **Improved Cookie Banner Cost Estimates** — Cost calculations for the Cookie Banner opportunity have been refined for greater accuracy.

---

## January 16–23, 2026

### New Features

- **Site Health Monitor (General Availability)** — Site Health Monitor is now available for all customers, providing a continuous view of your site's performance health. New sites are set up automatically upon onboarding.
- **Subpath Site Support** — Sites scoped to specific URL subpaths are now fully supported in Site Health Monitor.

### Enhancements

- **Actionable Data Sufficiency Notices** — Paid Traffic opportunities with fewer than 1,000 pageviews now display a data sufficiency notice, helping you focus optimization efforts where traffic data is statistically meaningful.
- **Flexible Meta Title Validation** — The minimum character requirement for meta titles has been reduced, giving you more flexibility in crafting concise page titles.
- **Localized What's New Dialog** — The in-app feature announcements dialog now displays in your preferred language.
- **Published Badge** — Variations in the High Organic Low CTR opportunity that have been deployed now show a "Published" badge, making it easier to distinguish active from pending changes.
- **Pull Request Links in Accessibility** — The Accessibility opportunity's Deployed tab now shows the associated pull request URL for each fix, making it easier to trace changes back to your source control history.
