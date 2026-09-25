---
title: Manage User Permissions
description: Learn how to manage user access and capabilities in AEM Sites Optimizer.
product_v2:
  - id: fd1f54a9-f50c-467d-8956-cebbaf4f3eb8
    internal-label: Experience Manager
topic_v2:
  - id: cdd65e7e-8839-44a2-bc21-0e03623b5dd1
    internal-label: Optimization
---
# Manage user permissions

Control who can access a site in Sites Optimizer and what they can do with it. Access is built from a small set of independent *capabilities* — View, Edit, Deploy, Configure, and Manage users — that you grant to each person.

Access is **additive**: a person's permissions are the sum of everything they've been granted. There's no "deny", so grants never conflict or cancel each other out. To give someone less access, remove a grant rather than trying to override it.

To manage access, open the **Permissions** tab (the lock icon in the left navigation), then select the site you want to manage.

![The Permissions page in Sites Optimizer](./assets/settings/permissions-page.png){align="center"}

## How access is granted

There are two ways a person can get access, and they work together:

- **Organization-wide access** — assigned by your Adobe org administrator in the [Adobe Admin Console](https://adminconsole.adobe.com/). It applies across every site in your organization. Use it for people who need the same access everywhere.
- **Site-level access** — assigned inside Sites Optimizer, on the **Permissions** tab. It applies to a single site and can be as broad or as narrow as you need. No Admin Console access is required.

>[!NOTE]
>
>The two layers add up. Someone with organization-wide view access who is also granted Edit on one site can view every site and edit that one. To keep a person limited to a single site, make sure they don't also hold an organization-wide role.

### Organization-wide roles (Admin Console)

Organization-wide access comes from one of two **AEM Sites Optimizer** product roles, assigned in the [Adobe Admin Console](https://adminconsole.adobe.com/):

- **ASO Manager** — full access to every site, including **Manage users**. A Manager can open the **Permissions** tab for any site and assign access to others.
- **ASO User** — view-only access to every site. No changes and no user management.

To assign a role, you must be a **System administrator** for the organization, or a **product administrator** for AEM Sites Optimizer.

1. Sign in to the [Adobe Admin Console](https://adminconsole.adobe.com/).
1. Go to **Products** and select **AEM Sites Optimizer**.
1. Open the **Users** tab and add the user by email (or select an existing user).
1. Click the **+** (add) icon to add a product profile, then choose the product profile.

   ![Choosing the product profile for a user in the Adobe Admin Console](./assets/settings/permissions-admin-console-product-profile.png){align="center"}

1. Click **Next**.
1. Choose the role — **ASO Manager** for full access, or **ASO User** for view-only access — then click **Apply**.

   ![Selecting the ASO Manager role in the Adobe Admin Console](./assets/settings/permissions-admin-console-aso-manager-role.png){align="center"}

   ![Selecting the ASO User role in the Adobe Admin Console](./assets/settings/permissions-admin-console-aso-user-role.png){align="center"}

For more on adding users, see [Onboard users](setup/onboard-users.md).

>[!IMPORTANT]
>
>Only an organization administrator can grant organization-wide **Manage users**. A member who has **Manage users** on a site can assign access on that site, but can't create an organization-wide **ASO Manager**.

## Capability levels

Each capability controls one kind of action. They're independent — for example, you can grant Deploy without Edit.

| Capability | What it allows | What it does not allow |
|---|---|---|
| View | See the site's data — opportunities, suggestions, fixes, reports, and configuration — without changing anything. | Any change. |
| Edit | Create and change opportunities and suggestions (what should change). | Publishing changes, changing settings, or managing users. |
| Deploy | Publish fixes live to the site, and roll them back. | Managing users. |
| Configure | Change the site's settings and connections. | Publishing fixes, or managing users. |
| Manage users | Grant or revoke other members' access to the site. | Managing a site the person doesn't already have access to. |

>[!NOTE]
>
>**View is always included.** Every grant includes View automatically — you can't manage, configure, edit, or deploy something you can't see. Because of this, View can't be removed on its own. To remove someone's access completely, remove the member (see [Edit or remove a member](#edit-or-remove-a-member) below) instead of unchecking every capability.

## Scope access to opportunity types

On a single site, you can grant View, Edit, and Deploy for **specific opportunity types** (for example, Core Web Vitals or Broken internal links) instead of the whole site. This lets one person edit Core Web Vitals while only viewing everything else.

- **View**, **Edit**, and **Deploy** can be scoped to one or more opportunity types, or to **All** opportunity types.
- **Configure** and **Manage users** always apply to the entire site — they can't be limited to an opportunity type.

Each scoped grant appears as its own row for the member, with an **Applies to** column showing the opportunity type, **All**, or **Site-wide**.

>[!CAUTION]
>
>Scoping only limits what *that* grant gives — it never removes access another grant provides. If a person also has organization-wide access or an **All**-types grant, that broader access still applies. So to truly limit someone to specific opportunity types, make sure they don't also hold a broader role or an **All**-types grant.

## Add a member

1. Open the **Permissions** tab (the lock icon in the left navigation) and select the site.
1. Click **Add members**.
1. Search by name or email, and select one or more people.
1. Choose the **opportunity type(s)** the access applies to (or **All**), then select the capabilities to grant.
1. Click **Add**.

## Edit or remove a member

In the **Members** table:

- Click **Edit capabilities** on a member's row to change what they can do. When you edit an existing grant, its opportunity type stays fixed — you change only the capabilities, and at least one capability must stay selected.
- Click **Remove** to revoke that member's access to the site entirely.

>[!NOTE]
>
>Changing capabilities and removing a member are different actions. To take away all access, use **Remove** — you can't do it by unchecking capabilities, because a grant must keep at least one capability (and View always stays).

## Who can manage permissions

The **Permissions** tab for a site is available to:

- Members with the **Manage users** capability on that site, and
- Organization administrators (an ASO Manager).

Members without **Manage users** see a message that they don't have permission to manage access for that site.

## Turn on user and access management

User and access management is controlled by a setting for your organization. You can assign access before it's turned on, but it's only **enforced** once the setting is on.

If it isn't enabled yet, the **Permissions** tab shows a banner asking you to contact your account team. Reach out to your Sites Optimizer account team to turn it on.

>[!NOTE]
>
>Until user and access management is turned on, the permissions you assign are saved but not enforced.

## Set up access before enforcement

You don't have to wait for enforcement to start assigning access. Even while user and access management is still **off**, users with the **ASO Manager** role can open the **Permissions** tab and assign sites and capabilities to other users.

This lets you prepare the right access for everyone in advance. When enforcement is later turned on, your users already have the access they need — so no one is unexpectedly locked out.

>[!IMPORTANT]
>
>While enforcement is off, the **Permissions** tab is available only to **ASO Manager** users. Set up access for all your users first, then turn on enforcement.

## Frequently asked questions

**Do site-level members need an Admin Console role?**

No. Site-level access is granted entirely inside Sites Optimizer, on the **Permissions** tab. Only organization-wide roles are assigned in the Admin Console.

**What happens if someone has both organization-wide and site-level access?**

Both apply. Their effective access is the combination of the two. Grants never conflict, because no grant can deny access.

**Why can't a member with Manage users create an organization-wide Manager?**

Creating an organization-wide role is an Admin Console action. A member with **Manage users** can assign access on their own site, but only an organization administrator can grant organization-wide roles.

**How do I revoke a person's access to a site?**

Remove their grant on the **Permissions** tab. This is different from editing capabilities, which must always leave at least one capability.

**Can I limit a person to specific opportunity types?**

Yes — grant View, Edit, or Deploy scoped to specific opportunity types instead of **All**. Because access is additive, this only takes effect if the person doesn't also have organization-wide access or an **All**-types grant.
