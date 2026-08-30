# 05-Database

## Objective

Deploy PostgreSQL in private subnets with high availability.

---

## Configuration

- Engine: PostgreSQL 16
- Instance class: `db.t3.micro`
- Storage: 20 GB gp3
- Multi-AZ enabled
- Encryption enabled
- Automated backups: 7 days

---

## Connectivity

Application servers connect through the RDS endpoint on port 5432.

---

## Failure Scenario

If the primary database fails, AWS automatically promotes the standby instance.

---

## Verification

- Database status is **Available**.
- Multi-AZ status is enabled.
- Public accessibility is disabled.

---

-<img width="1249" height="324" alt="rds-overview" src="https://github.com/user-attachments/assets/9804b773-1e85-4011-bfe3-5826f7f3ed5a" />


**Figure 5:** RDS instance detail.
