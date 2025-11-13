// auth-service/server.js
const express = require("express");
const axios = require("axios");
const bcrypt = require("bcryptjs");
const cors = require("cors");
require('dotenv').config();

const app = express();
app.use(express.json());
app.use(cors());

const USER_SERVICE_URL = process.env.USER_SERVICE_URL || "http://user-service:4000";

app.get('/healthz', (req,res) => res.json({ status: 'ok' }));

app.post("/login", async (req, res) => {
  try {
    const { email, password } = req.body;
    if(!email || !password){
      return res.status(400).json({ message: "Missing email or password" });
    }

    const response = await axios.get(`${USER_SERVICE_URL}/get-user/${encodeURIComponent(email)}`);
    const user = response.data;

    if (!user) return res.status(404).json({ message: "User not found" });

    const passwordMatch = await bcrypt.compare(password, user.password);
    if (!passwordMatch) return res.status(401).json({ message: "Incorrect Password" });

    res.json({ message: "✅ Login Successful!" });
  } catch (err) {
    console.error("Login error:", err?.response?.data || err.message);
    res.status(400).json({ message: "Login Error: " + (err.response?.data?.message || err.message) });
  }
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Auth Service on ${PORT}`));

