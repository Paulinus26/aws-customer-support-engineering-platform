require("dotenv").config();

const express = require("express");
const cors = require("cors");
const helmet = require("helmet");
const morgan = require("morgan");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const authenticateToken = require("./auth");

const app = express();

app.use(express.json());
app.use(cors());
app.use(helmet());
app.use(morgan("combined"));

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

app.get("/simulate-error", (req, res) => {
  throw new Error("Simulated application incident");
});

app.get("/simulate-db-latency", async (req, res) => {
  await new Promise((resolve) => setTimeout(resolve, 5000));

  res.json({
    status: "slow-response",
    delayMs: 5000,
  });
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
