# 01-Architecture

## Purpose

This document explains the complete cloud architecture of the SupportDesk platform and the design decisions behind each component.

---

## Architecture Diagram

![SupportDesk Architecture](../diagrams/supportdesk-architecture.png)

**Figure 1:** Production-grade AWS Customer Support Engineering Architecture

---

## High-Level Flow

1. User accesses the SupportDesk domain.
2. Route 53 resolves the domain to the Application Load Balancer.
3. The ALB forwards traffic to healthy EC2 instances.
4. EC2 instances run the Node.js application behind Nginx.
5. The application communicates with PostgreSQL in private subnets.
6. Logs and metrics are sent to CloudWatch.
7. CloudWatch alarms publish alerts to SNS.
8. Support engineers investigate incidents through Systems Manager and CloudWatch.

---

## Network Layout

### VPC

- CIDR: `10.0.0.0/16`
- DNS support enabled
- DNS hostnames enabled

### Public Subnets

- `10.0.1.0/24` (AZ A)
- `10.0.2.0/24` (AZ B)

### Private Application Subnets

- `10.0.11.0/24` (AZ A)
- `10.0.12.0/24` (AZ B)

### Private Database Subnets

- `10.0.21.0/24` (AZ A)
- `10.0.22.0/24` (AZ B)

---

## Availability and Resilience

- ALB spans two Availability Zones.
- EC2 instances are distributed across two AZs.
- RDS uses Multi-AZ deployment with automatic failover.
- NAT Gateways provide outbound internet access from private subnets.

---

## Security Controls

- Security Groups enforce least privilege access.
- Database accepts traffic only from the EC2 security group.
- Public internet traffic reaches only the ALB.
- Systems Manager is used instead of SSH where possible.
- S3 buckets block all public access.

---

## Monitoring Design

- CloudWatch collects metrics and logs.
- SNS delivers operational alerts.
- Alarms monitor:
  - EC2 CPU utilization
  - ALB HTTP 5XX errors

---

## CI/CD Architecture

GitHub Actions performs:

1. `terraform fmt`
2. `terraform validate`
3. `terraform plan`
4. Optional manual approval
5. `terraform apply`

---

## Operational Benefits

- Modular Terraform code
- High availability
- Centralized monitoring
- Automated deployment
- Incident simulation capability
- Clear security boundaries
