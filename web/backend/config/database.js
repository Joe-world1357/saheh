const Database = require('better-sqlite3');
const path = require('path');
const os = require('os');
const fs = require('fs');

// Get database path based on OS
function getDatabasePath() {
  const envPath = process.env.DB_PATH;
  if (envPath) {
    // Expand ~ to home directory
    return envPath.replace('~', os.homedir());
  }

  // Default paths based on OS
  if (process.platform === 'linux') {
    return path.join(os.homedir(), '.local', 'share', 'com.example.sehati', 'sehati.db');
  } else if (process.platform === 'win32') {
    return path.join(os.homedir(), 'AppData', 'Local', 'com.example.sehati', 'sehati.db');
  } else if (process.platform === 'darwin') {
    return path.join(os.homedir(), 'Library', 'Application Support', 'com.example.sehati', 'sehati.db');
  }
  
  // Fallback
  return path.join(__dirname, '..', 'sehati.db');
}

let db = null;

function connectDatabase() {
  try {
    const dbPath = getDatabasePath();
    
    // Check if database exists
    if (!fs.existsSync(dbPath)) {
      console.warn(`⚠️  Database not found at: ${dbPath}`);
      console.warn('   Make sure the Flutter app has been run at least once to create the database.');
      return null;
    }

    db = new Database(dbPath, { readonly: false });
    console.log(`✅ Connected to database: ${dbPath}`);
    
    // Enable foreign keys
    db.pragma('foreign_keys = ON');
    
    return db;
  } catch (error) {
    console.error('❌ Database connection error:', error.message);
    return null;
  }
}

function getDatabase() {
  if (!db) {
    db = connectDatabase();
  }
  return db;
}

function closeDatabase() {
  if (db) {
    db.close();
    db = null;
  }
}

module.exports = {
  connectDatabase,
  getDatabase,
  closeDatabase,
  getDatabasePath
};

