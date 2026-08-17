# SupportDesk Application

## Objective

Build a Node.js and Express customer support application that provides a realistic environment for authentication, API testing, incident simulation, and troubleshooting.

---

## Components

- Node.js
- Express.js
- PostgreSQL
- JWT authentication
- bcryptjs
- Helmet
- Morgan
- Health check endpoint
- Protected dashboard
- Incident simulation
- AWS EC2
- Application Load Balancer
- CloudWatch

---

## Design Rationale

The application is designed around common SaaS support scenarios.

Authentication protects the dashboard, while health checks, controlled errors, application logs, and CloudWatch provide practical troubleshooting scenarios.

---

## Application Flow

```text
                    User
                     |
                     v
              Application Load Balancer
                     |
                     v
                 EC2 Instance
                     |
                     v
               Node.js / Express
                  /       \
                 v         v
          PostgreSQL    CloudWatch
                         |
                         v
                    Application Logs
```

---

## Authentication

The application uses JWT authentication with bcrypt password verification.

### Login

```text
POST /login
```

A successful login returns a JWT token.

### Protected Dashboard

```text
GET /dashboard
```

The dashboard requires a valid JWT token.

![Login Authentication](../screenshots/application-login-authentication.png)

---

## Health Check

The application provides a simple health endpoint:

```text
GET /health
```

A successful response confirms that the application is running.

![Application Health](../screenshots/application-health.png)

---

## API Endpoints

| Method | Endpoint          | Purpose             |
| ------ | ----------------- | ------------------- |
| GET    | `/`               | Application status  |
| GET    | `/health`         | Health check        |
| POST   | `/login`          | User authentication |
| GET    | `/dashboard`      | Protected dashboard |
| GET    | `/simulate-error` | Incident simulation |

---

## Incident Simulation

The application includes a controlled error endpoint:

```text
GET /simulate-error
```

This intentionally generates an application error so that the incident can be reproduced and investigated.

![Simulated Application Incident](../screenshots/simulated-error.png)

---

## Error Handling

The application uses centralized Express error handling.

When an application error occurs, it returns an HTTP 500 response and records the error in the application logs.

![Application Error Response](../screenshots/error-response.png)

---

## Database Connectivity

The application is designed to connect to PostgreSQL using environment variables.

Common troubleshooting areas include:

- Database availability
- Credentials
- Network connectivity
- Security groups
- Connection timeouts

---

## Logging and Monitoring

Application activity and errors are logged for troubleshooting.

The AWS deployment uses CloudWatch for centralized application logging.

```text
/aws/ec2/supportdesk-dev
```

![CloudWatch Incident Investigation](../screenshots/cloudwatch-incident-investigation.png)

---

## Deployment

The application runs on the AWS infrastructure provisioned with Terraform.

```text
GitHub
   |
   v
Application
   |
   v
EC2
   |
   v
Application Load Balancer
   |
   v
paulinusops.online
```

Infrastructure configuration is maintained separately under:

```text
Infrastructure/terraform/
```

---

## Verification

The application is considered functional when:

- The homepage loads successfully.
- Login returns a valid token.
- The dashboard requires authentication.
- `/health` returns a successful response.
- `/simulate-error` produces the expected incident.
- Application errors are logged.
- CloudWatch can be used to investigate application activity.
- The application can receive traffic through the Application Load Balancer.

---

## Application Screenshots

### Application Homepage

![SupportDesk Application](../screenshots/application-homepage.png)

### Authenticated Dashboard

![Authenticated Dashboard](../screenshots/application-dashboard.png)

### Application Health

![Application Health](../screenshots/application-health.png)

### Simulated Incident

![Simulated Incident](../screenshots/simulated-error.png)

### Error Response

![Application Error Response](../screenshots/error-response.png)

### CloudWatch Investigation

![CloudWatch Investigation](../screenshots/cloudwatch-incident-investigation.png)

---

## Outcome

SupportDesk provides a practical environment for demonstrating technical support, API troubleshooting, authentication, database troubleshooting, AWS monitoring, incident investigation, and root-cause analysis.
