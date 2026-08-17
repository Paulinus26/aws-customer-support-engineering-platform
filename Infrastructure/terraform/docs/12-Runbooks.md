# 12-Runbooks

## High CPU

1. Confirm alarm.
2. Check EC2 metrics.
3. Review application logs.
4. Scale out if necessary.
5. Verify recovery.

---

## Database Connectivity Failure

1. Check RDS status.
2. Test network path.
3. Validate security groups.
4. Restart application if required.

---

## ALB 5XX Errors

1. Check target health.
2. Review Nginx logs.
3. Review PM2 process status.
4. Redeploy application if necessary.

---

## Login Failure

1. Confirm application availability.
2. Check database connectivity.
3. Review authentication logs.
4. Communicate status to customer.
