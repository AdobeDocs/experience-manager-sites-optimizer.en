---
title: Preflight setup
description: Learn how to set up the Preflight extension for AEM Sites Optimizer.
---

# Preflight setup

AEM Sites Optimizer Preflight opportunity identification requires the set up of the Preflight extension in either Universal Editor, Document-Based Preview, or AEM Cloud Service in order to run Preflight audits on your pages before they are published.

## Enable user access

To use the Preflight extension, ensure your user is assigned to at least one of the following AEM Sites Optimizer product profiles in [Adobe Admin Console](https://adminconsole.adobe.com):

* AEM Sites Optimizer - Auto-Suggest User
* AEM Sites Optimizer - Auto-Optimize User

## Enable the Preflight extension

>[!BEGINTABS]

>[!TAB Universal Editor]

To set up Preflight in Universal Editor, follow these steps:

1. Open the **Extension Manager** at:
   [https://experience.adobe.com/#/@org/aem/extension-manager/universal-editor](https://experience.adobe.com/#/@org/aem/extension-manager/universal-editor)
1. Locate the **AEM Sites Optimizer Preflight Extension** and submit a request to enable it.
1. The **Adobe AEM team** will review and enable the extension for your organization.
1. After the extension is enabled, open a page in **Universal Editor**, for example:
   `https://author-p12345-e123456.adobeaemcloud.com/ui#/@org/aem/universal-editor/canvas/author-p12345-e123456.adobeaemcloud.com/content/en/example/home.html`
1. The **Preflight Extension** will appear in the **side rail**.
1. Select the **Preflight Extension** from the side rail to start a **Preflight Audit** of the current page.

>[!TAB Document-based authoring]

To set up Preflight for Document-based authoring, follow these steps:

1. Add the following configuration to `/tools/sidekick/config.json` in your Edge Delivery Services project's GitHub repository:

   ```json
   {
     "plugins": [
       {
         "id": "preflight",
         "titleI18n": {
           "en": "Preflight"
         },
         "environments": ["preview"],
         "event": "preflight"
       }
     ]
   }
   ```

1. Create a new file `/tools/sidekick/aem-sites-optimizer-preflight.js` and add the following content:

   ```javascript
   (function () {
     let isAEMSitesOptimizerPreflightAppLoaded = false;
     function loadAEMSitesOptimizerPreflightApp() {
       const script = document.createElement('script');
       script.src = 'https://experience.adobe.com/solutions/OneAdobe-aem-sites-optimizer-preflight-mfe/static-assets/resources/sidekick/client.js?source=plugin';
       script.onload = function () {
         isAEMSitesOptimizerPreflightAppLoaded = true;
       };
       script.onerror = function () {
         console.error('Error loading AEMSitesOptimizerPreflightApp.');
       };
       document.head.appendChild(script);
     }

     function handlePluginButtonClick() {
       if (!isAEMSitesOptimizerPreflightAppLoaded) {
         loadAEMSitesOptimizerPreflightApp();
       }
     }

     // Sidekick V1 extension support
     const sidekick = document.querySelector('helix-sidekick');
     if (sidekick) {
       sidekick.addEventListener('custom:preflight', handlePluginButtonClick);
     } else {
       document.addEventListener('sidekick-ready', () => {
         document.querySelector('helix-sidekick')
           .addEventListener('custom:preflight', handlePluginButtonClick);
       }, { once: true });
     }

     // Sidekick V2 extension support
     const sidekickV2 = document.querySelector('aem-sidekick');
     if (sidekickV2) {
       sidekickV2.addEventListener('custom:preflight', handlePluginButtonClick);
     } else {
       document.addEventListener('sidekick-ready', () => {
         document.querySelector('aem-sidekick')
           .addEventListener('custom:preflight', handlePluginButtonClick);
       }, { once: true });
     }
   }());
   ```

1. Update the `loadLazy()` function in `/scripts/scripts.js` to import the Preflight script for preview URLs:

   ```javascript
   if (window.location.href.includes('.aem.page')) {
      import('../tools/sidekick/aem-sites-optimizer-preflight.js');
   }
   ```

1. Open the preview URL (`*.aem.page`) of the page you want to audit.
1. In **Sidekick**, click the **Preflight** button to start the audit for the current page.

>[!TAB AEM Sites Page Editor]

To use Preflight in the AEM Sites Page Editor, you can create a bookmarklet in your web browser. Follow these steps:

1. Show your **Bookmarks Bar** in your web browser:

   * Press **Ctrl+Shift+B** (Windows) or **Cmd+Shift+B** (Mac).

!. Create a new bookmark in your browser:

   * Right-click the Bookmarks Bar and select **New Page** or **Add Bookmark**.
   * In the **Address (URL)** field, paste the following code:

   ```javascript
   javascript:(function(){const script=document.createElement('script');script.src='https://experience.adobe.com/solutions/OneAdobe-aem-sites-optimizer-preflight-mfe/static-assets/resources/sidekick/client.js?source=bookmarklet&target-source=aem-cloud-service';document.head.appendChild(script);})();
   ```

1. Name the bookmark **Preflight** (or any name you prefer).
1. Open the preview URL (`*.aem.page`) of the page you want to audit in the **AEM Sites Page Editor**.
1. Click the **Preflight** bookmark in your Bookmarks Bar to start the audit for the current page.

>[!ENDTABS]

## Best practices

When running Preflight audits, keep the following guidelines in mind:

* Always run audits on **staging or preview pages** before publishing to production.
* Prioritize resolving **high-impact issues** such as broken links, missing H1 tags, or insecure links.
* Ensure **authentication is enabled** for protected staging environments before running audits.
* Review and apply **meta tag recommendations** to improve SEO performance.
