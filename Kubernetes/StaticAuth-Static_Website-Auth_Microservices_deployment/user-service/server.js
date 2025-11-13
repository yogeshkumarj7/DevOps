// user-service/server.js
const express = require("express");
const mongoose = require("mongoose");
const bcrypt = require("bcryptjs");
const cors = require("cors");
require('dotenv').config();

const User = require("./models/User");
const app = express();

app.use(express.json());
app.use(cors());

const MONGO_URL = process.env.MONGO_URL || "mongodb://mongo:27017/micro-users";

mongoose.connect(MONGO_URL, { useNewUrlParser: true, useUnifiedTopology: true })
 .then(()=> console.log("Connected to Mongo:", MONGO_URL))
 .catch(err => console.error("Mongo connection error", err));

// health
app.get('/healthz', (req,res) => res.json({ status: 'ok' }));

app.post("/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;
    if(!name || !email || !password){
      return res.status(400).json({ message: "Missing fields" });
    }
    const exists = await User.findOne({ email });
    if(exists) return res.status(409).json({ message: "Email already registered" });

    const hashedPassword = await bcrypt.hash(password, 10);
    const user = await User.create({ name, email, password: hashedPassword });
    res.json({ message: "User Registered Successfully", user: { id: user._id, name, email } })
  } catch (err) {
    console.error("Signup error:", err);
    res.status(500).json({ message: "Server error" });
  }
});

app.get("/get-user/:email", async (req, res) => {
  try {
    const user = await User.findOne({ email: req.params.email }).select('+password');
    if(!user) return res.status(404).json({ message: "User not found" });
    res.json(user);
  } catch(err) {
    res.status(500).json({ message: "Server error" });
  }
});

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => console.log(`User Service on ${PORT}`));

