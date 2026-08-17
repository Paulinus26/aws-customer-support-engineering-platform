# 06-Compute

## Objective

Deploy the application tier behind an Application Load Balancer.

---

## Components

- Application Load Balancer
- Target Group
- Listener
- Launch Template
- Auto Scaling Group

---

## Application Stack

- Amazon Linux 2023
- Node.js
- Express
- PM2
- Nginx

---

## Auto Scaling

- Desired capacity: 2
- Minimum: 2
- Maximum: 4

---

## Health Checks

- Path: `/health`
- Protocol: HTTP
- Port: 80

---

## Verification

- ALB is active.
- Targets are healthy.
- Application responds through the ALB DNS name.

---

- ![Load Balancer](../screenshots/Load-balancer.png)
- ![Target Group](../screenshots/target-group.png)
- ![EC2 Instance](../screenshots/ec2-instances.png)

**Figure 6:** ALB dashboard, target group health, and EC2 instances.
