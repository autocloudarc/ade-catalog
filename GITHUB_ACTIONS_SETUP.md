# GitHub Actions Deployment Configuration for ADE

This document outlines the setup required to deploy Azure Deployment Environments using GitHub Actions.

## Prerequisites

1. **Azure Subscription** with Azure Deployment Environments enabled
2. **Dev Center** created in Azure
3. **ADE Project** with the `tf-deployment` environment definition
4. **Microsoft Entra ID Application** for OIDC authentication

## Required GitHub Secrets

Configure the following secrets in your GitHub repository settings:

### Azure Authentication (OIDC)
- `AZURE_CLIENT_ID` - The client ID of your Microsoft Entra ID application
- `AZURE_TENANT_ID` - Your Azure tenant ID
- `AZURE_SUBSCRIPTION_ID` - Your Azure subscription ID

### ADE Configuration
- `ADE_DEV_CENTER_NAME` - The name of your Azure Dev Center
- `ADE_PROJECT_NAME` - The name of your ADE project

## Setting Up OIDC in Azure

### 1. Create a Microsoft Entra ID Application

```bash
az ad app create --display-name "github-actions-ade"
```

### 2. Configure OIDC Federated Credentials

Replace `YOUR_GITHUB_ORG` and `YOUR_REPO_NAME` with your actual values:

```bash
az identity federated-credential create \
  --name github-actions \
  --identity-name github-actions-ade \
  --issuer "https://token.actions.githubusercontent.com" \
  --subject "repo:YOUR_GITHUB_ORG/YOUR_REPO_NAME:ref:refs/heads/main"
```

### 3. Assign Required Permissions

Assign the `Contributor` or `Azure Deployment Environments User` role to your application on the Dev Center or subscription.

## Workflow Details

The `deploy-ade.yml` workflow:

- **Triggers:** 
  - On push to `main` branch (changes to `src/Environments/**` or workflow file)
  - Manual workflow dispatch with environment selection

- **Matrix Strategy:**
  - Deploys to `dev` and `test` environments sequentially
  - Each environment uses different parameter values

- **Parameters by Environment:**
  - **dev:** `devsta`, `dev-web-nsg`, `dev-app-nsg`, `dev-dta-nsg`, `dev-law-01`
  - **test:** `teststa`, `test-web-nsg`, `test-app-nsg`, `test-dta-nsg`, `test-law-01`

## Running the Workflow

### Automatic Deployment
Push changes to the `src/Environments/` directory to trigger automatic deployment.

### Manual Deployment
1. Go to **Actions** tab in GitHub
2. Select **Deploy to ADE Environments** workflow
3. Click **Run workflow**
4. Choose environment: `dev`, `test`, or `all`

## Troubleshooting

### Authentication Issues
- Verify OIDC federated credentials are correctly configured
- Ensure the Microsoft Entra ID app has required permissions on the Dev Center

### Environment Creation Failures
- Check that the environment definition name matches your ADE catalog
- Verify parameter names match the environment definition
- Review ADE runner logs in Azure portal

### Permissions Issues
- Assign proper roles: `Contributor`, `Azure Deployment Environments User`, or `Deployment Environments Operator`
- Verify the Microsoft Entra ID app is assigned roles at the correct scope

## References

- [Azure Deployment Environments Documentation](https://learn.microsoft.com/en-us/azure/deployment-environments/)
- [GitHub Actions OIDC Configuration](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect)
- [Azure CLI devcenter Commands](https://learn.microsoft.com/en-us/cli/azure/devcenter?view=azure-cli-latest)
