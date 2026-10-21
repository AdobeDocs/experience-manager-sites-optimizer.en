---
title: Audit results in Preflight
description: Learn how to interpret Preflight audit results, the readiness meter, and audit categories, and navigate to opportunities in the preview.
product_v2:
  - id: fd1f54a9-f50c-467d-8956-cebbaf4f3eb8
    internal-label: Experience Manager
---

# Audit results in Preflight

When the audits complete, Preflight displays the results in the readiness dashboard. The dashboard shows an overall readiness meter and the opportunities it found, grouped by audit category. Within each category, individual audits identify specific items to review or fix.

## Toolbar

The toolbar at the top of the readiness dashboard provides actions for the current run:

* **Reanalyze** – Start a brand-new audit run on the current page. Reanalyze always discards the displayed results and runs every audit again, so use it whenever you want fresh results — for example, after editing the page. Select **Reanalyze** in the toolbar.
* **Export** – Download the current run as a **CSV** (spreadsheet-friendly) or **PDF** (a formatted document) file. Depending on your environment, select **Export** from the toolbar or from the **More actions** (**...**) menu.
* **Settings** – Use **Show site navigation links** to include site navigation links (currently Internal Links only). Select the gear icon or open **More actions** (**...**) and select **Settings**. Settings is available before a run or after it finishes, but not while audits are running or in the Universal Editor. See [Include site navigation links](./opportunities/seo/internal-links.md#include-site-navigation-links).

If you change a setting after a run, a dot on **Reanalyze** and the label **Reanalyze to apply new settings** indicate that the displayed results used a different setting. Select **Reanalyze** to apply the saved setting to a new run.

When you export, you can also choose what to include:

* **Include metadata table** – Add a table of run details, such as the host, content path, and generation details.
* **Include passed audits** – Include the audits that passed with no opportunities, not only the opportunities that were found.

>[!NOTE]
>
>PDF exports are always generated in English, regardless of the interface language. CSV exports follow your interface language as closely as possible.

## Readiness meter

At the top of the dashboard, the readiness meter reflects the overall audit results. It shows the percentage of audits that finished without opportunities, labeled **% passed**, along with the total number of opportunities found across all audits. For example, **85% passed** means that 85% of the completed audits found no opportunities. This percentage describes audit results, not progress through the run.

![The readiness meter and audit categories in the Preflight dashboard](./assets/overview/hero.png){align="center"}

When you are viewing a run that was reloaded from a previous session, the header shows how long ago it was performed — for example, *yesterday*. For more information, see [Continue a previous session](./audits.md#continue-a-previous-session).

While the audits are still running, the dashboard shows **Analyzing page** with a short status beneath it. A progress bar appears initially, before named audit categories arrive. Once categories appear, their individual processing indicators show which categories still have work in progress. When all audits complete, the meter shows the final percentage passed and opportunity count.

## Audit categories

Preflight groups related audits into categories, such as **SEO** and **Accessibility**. Each category appears as a card that shows the number of opportunities found, or indicates that all its audits passed with no opportunities.

Expand a category to see its individual audits. Each audit shows whether it passed or found opportunities, a short description, and a count of the opportunities found. Select an audit that found opportunities to open its detail page.

A category can show results while some of its audits are still running. Its icon shows a processing indicator, and its status says, for example, **3/3 audits passed so far**. This count includes only the audits that have returned results, so it can change as more results arrive. Expand the category to see individual audits that are still processing. A category with no opportunities shows its all-clear checkmark only after its pending work finishes.

For the complete list of audit categories and the audits in each, see [Preflight audit categories](./overview.md#preflight-audit-categories).

## Opportunity details

The detail page shows the opportunities the selected audit found. When the same problem occurs in more than one place, each occurrence is called an instance. Use the navigator (**Previous instance** and **Next instance**) to step through them; it shows your position, for example *1 of 5 instances found*. To return to the readiness dashboard, select the back arrow beside the audit title; the dashboard reopens with the audit's category expanded.

For audits that identify a specific URL on the page, the **Element** section appears at the top of the card to introduce the item, and the rest of the opportunity follows beneath it in its own section.

When more than one opportunity affects the same item — for example, several problems with the same link — Preflight shows them together on one card, each in its own section titled with its instance number, such as **Instance 3**. The navigator then shows a range instead of a single position, for example *3–5 of 12 instances found*.

![The detail page for the Internal Links audit, showing an opportunity and the Current URL section](./assets/audit-results/audit-detail.png){align="center"}

Each opportunity includes:

* A severity or impact badge that indicates how important the opportunity is.
* Details about the opportunity, such as a description of the problem, a recommendation, and, for accessibility, the related WCAG rule and conformance level.
* An **Element** section that identifies the affected element on the page, with a **Highlight on page** button. When the element has readable text, the section is titled **Element: Text** and shows that text; otherwise it is titled **Element: Selector** and shows the element's CSS selector. For **Internal Links** and **Canonical** opportunities, a **Current URL** section also shows the URL involved. Select **Copy URL** to copy it to your clipboard, or **Open in new tab** to open it.
* A **Suggestion** section with a recommended fix. When the suggestion is generated by AI, it is marked as an AI-generated suggestion, and may include a short rationale explaining the suggested fix.

## Highlight on page

After the audits complete, you can quickly locate and understand an opportunity by highlighting it directly on the page.

Preflight highlights the affected element in context, connecting the result in the panel to the exact location in your content. This makes it easier to review and resolve opportunities without manually searching through the page.

1. Open the Preflight panel in the context of the page to audit, and select **Analyze page** to run the audits.
1. Select an audit from the readiness dashboard, then select an opportunity to review.
1. Select **Highlight on page**. The preview automatically scrolls to the relevant area and highlights the corresponding element, so you can easily identify and optimize the opportunity in context.

Highlighting isn't possible for every opportunity — for example, when an opportunity isn't tied to a specific element, the element is hidden, or it is no longer on the page. In those cases the **Highlight on page** button is dimmed; hover over it to see why.

In the Universal Editor, highlighting is not yet supported for **Accessibility** opportunities; the **Highlight on page** button is dimmed, and you can hover over it to see why.

In the Universal Editor, Preflight can only highlight editable content. If the affected element isn't part of the editable content, the **Highlight on page** button is dimmed; hover over it to see why. If the element itself isn't directly editable but its nearest editable block is, Preflight highlights that block instead and adds a note explaining why.

In the AEM Sites Page Editor and Adobe Managed Services (AMS), highlighting also requires **Edit mode**. In **Preview mode**, Preflight shows a **Highlighting issues not available** notice; switch to **Edit mode** to highlight elements on the page.

## Job ID

Each Preflight run has a unique job ID, shown at the bottom of the panel. It is mainly useful when an administrator is troubleshooting a specific run. Hover over the ID and select the copy icon that appears to its right; the ID is copied to your clipboard and a confirmation message appears. Include this ID when you report a problem.

When you use Preflight outside the Universal Editor — for example, through the Sidekick or a bookmarklet — the panel footer also shows your organization name above the job ID. In the Universal Editor, your organization appears in the AEM header instead.
