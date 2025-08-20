---
title: AEM Sites Optimizer - Preflight Onboarding Guide
description: Learn about Preflight opportunities and how to set up preflight analysis in AEM Sites Optimizer.
---

# Preflight opportunities

![Preflight opportunities](./assets/preflight/hero.png){align="center"}

<span class="preview">AEM Sites Optimizer Preflight analyzes your page's technical and performance data and anticipates and detects opportunities before it is published. It uses generative AI to suggest optimisations.</span>

## Onboarding Steps

### Universal Editor Setup

1. Go to Extension Manager from URL: https://experience.adobe.com/#/@org/aem/extension-manager/universal-editor
2. Select AEM Sites Optimiser Preflight Extension and request to Enable
3. AEM team will enable the extension for your org
4. Once that is done, open page in Universal Editor such as: https://author-p12345-e123456.adobeaemcloud.com/ui#/@org/aem/universal-editor/canvas/author-p12345-e123456.adobeaemcloud.com/content/site/subscription.html
5. Preflight extension will be visible in side rail

### Document-Based Preview Setup

#### Step 1: Enable Sidekick with Preflight Button

Add the following configuration to `/tools/sidekick/config.json` in your GitHub repository:

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

#### Step 2: Create Sidekick Integration Script

Create `/tools/sidekick/aem-sites-optimizer-preflight.js` with the following content:

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

#### Step 3: Update Scripts File

Add the following import statement to the `loadLazy()` function in `/scripts/scripts.js` for preview urls as shown in the image below:

```javascript
if (window.location.href.includes('.aem.page')) {
   import('../tools/sidekick/aem-sites-optimizer-preflight.js');
}
```

### Bookmarklet Setup

The bookmarklet option is an excellent choice to test preflight on AEM CS Page Editors and Sandboxes Environment.

Drag the button below to your Bookmarks Bar to get started.

Press **Ctrl+Shift+B** (Windows) or **Cmd+Shift+B** (Mac) to show your Bookmarks Bar

**Drag this link to your bookmarks bar:**

<a href="javascript:(function(){const script=document.createElement('script');script.src='https://experience.adobe.com/solutions/OneAdobe-aem-sites-optimizer-preflight-mfe/static-assets/resources/sidekick/client.js?source=bookmarklet&target-source=aem-cloud-service';document.head.appendChild(script);})();">ASO Preflight</a>

**Or copy this code and create a new bookmark:**

```
javascript:(function(){const script=document.createElement('script');script.src='https://experience.adobe.com/solutions/OneAdobe-aem-sites-optimizer-preflight-mfe/static-assets/resources/sidekick/client.js?source=bookmarklet&target-source=aem-cloud-service';document.head.appendChild(script);})();
```

## Best Practices

- Run preflight audits on all staging/preview pages before publishing
- Address high-impact issues first (broken links, missing H1 tags, insecure links)
- Enable authentication for protected staging environments
- Review and implement meta tag suggestions for better SEO performance 