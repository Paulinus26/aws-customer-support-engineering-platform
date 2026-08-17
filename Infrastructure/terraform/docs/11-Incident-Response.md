# 11-Incident-Response

## Scenario

Customer reports login failures and slow performance.

---

## Investigation Checklist

* CloudWatch CPU metrics
* ALB target health
* Application logs
* Database connectivity
* Recent deployments

---

## Example Findings

* CPU sustained above 90%
* ALB returned HTTP 502
* Node.js process crashed repeatedly

---

## Customer Update Template

> We identified elevated CPU utilization on the application servers, which caused intermittent login failures. Additional capacity was added and the affected service has been restored. We are monitoring the platform closely.

---

## Root Cause Template

* Trigger
* Impact
* Detection
* Resolution
* Preventive actions

---

## Screenshot Placeholders

* `../screenshots/incident-cpu-alarm.png`
* `../screenshots/incident-logs.png`

**Description:** Alarm timeline and application logs.
