# Azure Governance with Terraform

## Overview
This repository contains a real-world Azure governance implementation for a mid-size private Swedish tech company (50-70 employees). It is designed for one Azure tenant, one management group (`my_landing_zone`), and one subscription.

The project uses Terraform to define and operate governance controls as code. It combines built-in Azure Policy initiatives with a custom organization baseline, and includes controlled policy exemptions for business realities.

## Business Impact
This governance model supports day-to-day business outcomes, not only technical controls:

- Risk reduction: prevents common configuration mistakes and reduces exposure to insecure deployments.
- Cost control: improves tagging consistency so cost tracking and accountability are reliable.
- Compliance readiness: establishes a structured control baseline with traceable exceptions.
- Operational consistency: standardizes naming, locations, and tagging across teams.
- Controlled exception handling: enables temporary, approved deviations without losing oversight.

## Architecture
The solution is built around management-group-level governance with subscription-level delivery context:

- Scope:
  - Azure tenant: 1
  - Management group: `my_landing_zone`
  - Subscription: 1
- Governance controls:
  - Azure Policy built-ins and custom definitions
  - Custom policy initiative (organization baseline)
  - Built-in initiatives:
    - Microsoft Cloud Security Benchmark (MCSB)
    - CIS Microsoft Azure Foundations Benchmark
- Assignments:
  - Policy and initiative assignments at management group scope
- Exemptions:
  - Resource-group-scoped exemptions with expiration dates
- Identity and remediation:
  - System-assigned managed identity on policy assignment
  - RBAC role assignments for modify/inheritance policy operations
- State and delivery:
  - Remote Terraform backend in Azure Storage
  - GitHub Actions CI/CD with OIDC authentication

## Governance Model
The custom organization baseline includes:

- Allowed Azure locations: `swedencentral`, `swedensouth`
- Resource group naming convention enforcement
- Mandatory tag presence on resource groups
- Tag inheritance from resource groups to resources
- Scoped and time-bound policy exemptions

Rollout follows a safe operating pattern:

1. Start with `DoNotEnforce` to observe impact and tune controls.
2. Review compliance results and remediation needs.
3. Move targeted controls to enforcement (`Default`) when teams are ready.

This approach reduces disruption while still moving toward stronger governance.

## Security & Compliance Alignment
The project aligns security and compliance practices with practical delivery:

- Uses recognized built-in control sets (MCSB and CIS baseline).
- Applies least-privilege RBAC for policy remediation identity.
- Keeps policy behavior transparent through versioned Terraform code.
- Supports auditability through explicit assignments, role grants, and exemptions.

## CI/CD and Automation
Governance changes are delivered through Infrastructure as Code and automated checks:

- Terraform is the single source of truth for governance state.
- GitHub Actions pipeline validates, plans, and supports controlled apply.
- OIDC-based authentication avoids long-lived client secrets in CI/CD.
- Remote state in Azure Storage enables shared, controlled operations.

## Exemption Handling
Exemptions are treated as controlled risk decisions, not permanent bypasses:

- Scoped narrowly (for example, specific resource groups).
- Linked to specific policy references inside initiatives.
- Time-bound with `expires_on`.
- Documented with business justification and ticket references.
- Reviewed and removed when the underlying constraint is resolved.

This keeps governance realistic while maintaining accountability.

## Future Improvements
Planned improvements to increase maturity over time:

- Environment-specific rollout profiles (non-prod vs prod enforcement cadence).
- Automated policy compliance reporting dashboards.
- Exemption quality gates in CI (required expiry and ticket format checks).
- Scheduled review process for expiring exemptions.
- Additional custom policies for platform-specific risks where needed.
