#!/bin/bash
###############################################################################
# SupportDesk EC2 Bootstrap Script
# Platform: Amazon Linux 2023
###############################################################################

set -euxo pipefail

# Log user-data execution
exec > >(tee /var/log/user-data.log | logger -t user-data) 2>&1

echo "======================================================="
echo "Starting SupportDesk bootstrap..."
echo "======================================================="

###############################################################################
# Update OS
###############################################################################

dnf update -y

###############################################################################
# Install Packages
###############################################################################

dnf install -y git nginx nodejs amazon-cloudwatch-agent

###############################################################################
# Install PM2
###############################################################################

npm install -g pm2

###############################################################################
# Create Application Directory
###############################################################################

mkdir -p /opt/supportdesk
cd /opt/supportdesk

###############################################################################
# Create package.json
###############################################################################

cat > package.json <<'EOF'
{
  "name": "supportdesk",
  "version": "1.0.0",
  "description": "SupportDesk Customer Support Platform",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.19.2",
    "pg": "^8.11.5"
  }
}
EOF

###############################################################################
# Install Node Packages
###############################################################################

npm install

###############################################################################
# Create Demo Application
###############################################################################

cat > server.js <<'EOF'
const express = require('express');
const { Pool } = require('pg');

const app = express();
const PORT = process.env.PORT || 8080;

const pool = new Pool({
  host: process.env.DB_HOST,
  port: 5432,
  user: 'postgres',
  password: process.env.DB_PASSWORD,
  database: 'supportdesk',
  connectionTimeoutMillis: 3000
});

app.get('/', (req, res) => {
  res.send('SupportDesk is running.');
});

app.get('/health', (req, res) => {
  res.status(200).json({ status: 'healthy' });
});

app.get('/login', (req, res) => {
  res.send('Login Successful');
});

app.get('/api/users', (req, res) => {
  res.json([{ id: 1, name: 'John Doe' }]);
});

// Simulated incident: high CPU
app.get('/simulate/high-cpu', (req, res) => {
  res.send('Starting high CPU simulation');
  while (true) {}
});

// Simulated incident: crash
app.get('/simulate/crash', (req, res) => {
  res.send('Crashing application');
  process.exit(1);
});

// Simulated incident: database connectivity
app.get('/simulate/database', async (req, res) => {
  try {
    const result = await pool.query('SELECT NOW()');
    res.json(result.rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: 'Database Connection Failed',
      detail: error.message
    });
  }
});

app.listen(PORT, () => {
  console.log(`SupportDesk listening on port ${PORT}`);
});
EOF

###############################################################################
# Environment Variables
###############################################################################

cat > /opt/supportdesk/.env <<EOF
DB_HOST=${DB_HOST_PLACEHOLDER}
DB_PASSWORD=${DB_PASSWORD_PLACEHOLDER}
EOF

###############################################################################
# Start Application with PM2
###############################################################################

cd /opt/supportdesk

export DB_HOST=${DB_HOST_PLACEHOLDER}
export DB_PASSWORD=${DB_PASSWORD_PLACEHOLDER}

pm2 start server.js --name supportdesk
pm2 save

# Enable PM2 on boot
pm2 startup systemd -u root --hp /root || true
systemctl enable pm2-root || true

###############################################################################
# Configure Nginx Reverse Proxy
###############################################################################

cat > /etc/nginx/conf.d/supportdesk.conf <<'EOF'
server {
    listen 80 default_server;
    server_name _;

    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
EOF

rm -f /etc/nginx/conf.d/default.conf || true

systemctl enable nginx
systemctl restart nginx

###############################################################################
# Configure CloudWatch Agent
###############################################################################

cat > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json <<'EOF'
{
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/messages",
            "log_group_name": "/aws/ec2/supportdesk-dev",
            "log_stream_name": "{instance_id}"
          },
          {
            "file_path": "/root/.pm2/logs/supportdesk-out.log",
            "log_group_name": "/aws/ec2/supportdesk-dev",
            "log_stream_name": "{instance_id}-application"
          },
          {
            "file_path": "/var/log/nginx/error.log",
            "log_group_name": "/aws/ec2/supportdesk-dev",
            "log_stream_name": "{instance_id}-nginx"
          }
        ]
      }
    }
  }
}
EOF

systemctl enable amazon-cloudwatch-agent
systemctl restart amazon-cloudwatch-agent || true

###############################################################################
# Permissions
###############################################################################

chmod -R 755 /opt/supportdesk

###############################################################################
# Finished
###############################################################################

echo "======================================================="
echo "SupportDesk bootstrap completed successfully."
echo "======================================================="