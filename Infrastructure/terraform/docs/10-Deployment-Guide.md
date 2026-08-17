# 10-Deployment-Guide

## Steps

1. Configure AWS credentials.
2. Create EC2 key pair.
3. Update `terraform.tfvars`.
4. Run Terraform commands.
5. Wait for deployment.
6. Access the ALB DNS name.

---

## Validation

```bash
curl http://<ALB-DNS>/health
```

Expected response:

```json
{"status":"healthy"}
```

---

## Screenshot Placeholders

* `../screenshots/terraform-apply.png`
* `../screenshots/supportdesk-homepage.png`

**Description:** Successful deployment and running application.
