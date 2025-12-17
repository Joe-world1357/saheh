const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { getDatabase } = require('../config/database');

const router = express.Router();

// Admin login
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ error: 'Email and password required' });
    }

    // Check admin credentials (hardcoded for single admin role)
    const adminEmail = process.env.ADMIN_EMAIL || 'admin@sehati.com';
    const adminPassword = process.env.ADMIN_PASSWORD || 'admin123';

    if (email !== adminEmail) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    // In production, use bcrypt to compare hashed passwords
    // For now, simple comparison (change in production!)
    if (password !== adminPassword) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    // Generate JWT token
    const token = jwt.sign(
      { 
        email: adminEmail, 
        role: 'admin' 
      },
      process.env.JWT_SECRET || 'your-secret-key-change-in-production',
      { expiresIn: '24h' }
    );

    res.json({
      success: true,
      token,
      admin: {
        email: adminEmail,
        role: 'admin'
      }
    });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Verify token
router.get('/verify', (req, res) => {
  try {
    const token = req.headers.authorization?.replace('Bearer ', '');
    
    if (!token) {
      return res.status(401).json({ error: 'No token provided' });
    }

    const decoded = jwt.verify(token, process.env.JWT_SECRET || 'your-secret-key-change-in-production');
    
    if (decoded.role !== 'admin') {
      return res.status(403).json({ error: 'Admin access required' });
    }

    res.json({
      valid: true,
      admin: decoded
    });
  } catch (error) {
    res.status(401).json({ error: 'Invalid or expired token' });
  }
});

module.exports = router;

