require("dotenv").config();

const express = require("express");
const cors = require("cors");
const helmet = require("helmet");
const morgan = require("morgan");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const { Pool } = require("pg");

const authenticateToken = require("./auth");

const app = express();

app.use(express.json());
app.use(cors());
app.use(helmet());
app.use(morgan("combined"));

// PostgreSQL Connection Pool configured with SSL for AWS RDS
const pool = new Pool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: parseInt(process.env.DB_PORT, 10) || 5432,
  ssl: {
    rejectUnauthorized: false, // Required for AWS RDS SSL connection
  },
});

const demoUser = {
  id: 1,
  email: "demo@paulinusops.online",
  passwordHash: bcrypt.hashSync("Demo123!", 10),
};

app.get("/", (req, res) => {
  res.send("SupportDesk SaaS Platform is running");
});

app.get("/health", (req, res) => {
  res.json({
    status: "ok",
    service: "supportdesk-app",
    timestamp: new Date().toISOString(),
  });
});

app.post("/login", async (req, res) => {
  const { email, password } = req.body;

  if (email !== demoUser.email) {
    return res.status(401).json({ error: "Invalid credentials" });
  }

  const valid = await bcrypt.compare(password, demoUser.passwordHash);

  if (!valid) {
    return res.status(401).json({ error: "Invalid credentials" });
  }

  const token = jwt.sign(
    { id: demoUser.id, email: demoUser.email },
    process.env.JWT_SECRET,
    { expiresIn: "1h" },
  );

  res.json({
    message: "Login successful",
    token,
  });
});

app.get("/dashboard", authenticateToken, (req, res) => {
  res.json({
    message: "Welcome to the SupportDesk dashboard",
    user: req.user,
    incidents: [
      { id: 1, status: "resolved", title: "Database connection spike" },
      { id: 2, status: "investigating", title: "ALB 502 responses" },
    ],
  });
});

// Database Simulation Endpoint using the SSL Pool Connection
app.get("/simulate/database", async (req, res) => {
  try {
    const result = await pool.query("SELECT NOW() as current_time;");
    res.json({
      status: "success",
      message: "Database Connection Successful",
      timestamp: result.rows[0].current_time,
    });
  } catch (err) {
    console.error("Database Query Error:", err);
    res.status(500).json({
      error: "Database Connection Failed",
      detail: err.message,
    });
  }
});

app.get("/simulate-error", (req, res) => {
  throw new Error("Simulated application incident");
});

app.use((err, req, res, next) => {
  console.error(err);

  res.status(500).json({
    error: "Internal Server Error",
    incident: err.message,
  });
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`SupportDesk app listening on port ${PORT}`);
});
