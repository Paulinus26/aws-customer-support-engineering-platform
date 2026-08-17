# 02-Terraform-Foundation

## Objective

Establish a reusable Terraform foundation for all infrastructure components.

---

## Directory Structure

```text
terraform/
├── backend.tf
├── locals.tf
├── main.tf
├── outputs.tf
├── providers.tf
├── terraform.tfvars
├── variables.tf
├── versions.tf
└── modules/
```

---

## Provider Configuration

- AWS Provider v5.x
- Default tags applied to all resources
- Region configured through variables

---

## Version Pinning

Terraform version and provider versions are pinned to ensure reproducible deployments.

---

## Local Values

Common tags are centralized in `locals.tf`.

---

## Remote State Strategy

Terraform state will be migrated to an encrypted S3 backend with state locking enabled.

---

## Validation Workflow

Run:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
```

---

## Screenshot Placeholders

![Terraform Init](../screenshots/Terraform-init.png)

![Terraform-validate](../screenshots/Terraform-validate.png)

![Terraform-plan](../screenshots/Terraform-plan.png)

**Description:** Successful Terraform initialization, validation, and plan execution.
