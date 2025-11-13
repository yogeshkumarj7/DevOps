// user-service/models/User.js
const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  name: { type: String, trim: true },
  email: { type: String, unique: true, required: true, index: true },
  password: { type: String, required: true, select: true }
}, { timestamps: true });

module.exports = mongoose.model("User", userSchema);

