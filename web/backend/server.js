require('dotenv').config();
const express = require('express');
const cors = require('cors');
const { connectDatabase } = require('./config/database');
const authRoutes = require('./routes/auth');
const adminRoutes = require('./routes/admin');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Connect to database
connectDatabase();

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/admin', adminRoutes);

// Health check
app.get('/api/health', (req, res) => {
  res.json({ status: 'ok', message: 'Sehati Admin API is running' });
});

// Error handling
app.use((err, req, res, next) => {
  console.error('Error:', err);
  res.status(500).json({ error: 'Internal server error' });
});

// Start server
app.listen(PORT, () => {
  console.log(`🚀 Sehati Admin API running on http://localhost:${PORT}`);
  console.log(`📊 Database: ${process.env.DB_PATH || 'Default path'}`);
  console.log(`🔐 Admin email: ${process.env.ADMIN_EMAIL || 'admin@sehati.com'}`);
});
