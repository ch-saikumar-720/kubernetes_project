import React, { useState } from "react";
import axios from "axios";

const API_URL = window.env?.API_URL || "http://localhost:5000/api";

export default function Signup() {
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [message, setMessage] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const res = await axios.post(`${API_URL}/signup`, { name, email, password });
      setMessage(`✅ Signup successful: ${res.data.message}`);
    } catch (err) {
      setMessage(`❌ Signup failed: ${err.response?.data?.error || err.message}`);
    }
  };

  return (
    <div>
      <h2>Signup</h2>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          placeholder="Name"
          value={name}
          onChange={(e) => setName(e.target.value)}
          required
        /><br/>
        <input
          type="email"
          placeholder="Email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
        /><br/>
        <input
          type="password"
          placeholder="Password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          required
        /><br/>
        <button type="submit">Signup</button>
      </form>
      <p>{message}</p>
    </div>
  );
}
