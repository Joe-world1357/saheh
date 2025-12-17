const express = require('express');
const { getDatabase } = require('../config/database');
const { authenticateAdmin } = require('../middleware/auth');

const router = express.Router();

// All routes require admin authentication
router.use(authenticateAdmin);

// Get dashboard overview stats
router.get('/overview', (req, res) => {
  try {
    const db = getDatabase();
    if (!db) {
      return res.status(500).json({ error: 'Database not available' });
    }

    // Total users
    const totalUsers = db.prepare('SELECT COUNT(*) as count FROM users').get().count;

    // Active users today (users who logged activity today)
    const today = new Date().toISOString().split('T')[0];
    const activeUsers = db.prepare(`
      SELECT COUNT(DISTINCT user_email) as count 
      FROM activity_tracking 
      WHERE date = ?
    `).get(today)?.count || 0;

    // Goals completed
    const goalsCompleted = db.prepare(`
      SELECT COUNT(*) as count 
      FROM health_goals 
      WHERE is_completed = 1
    `).get().count;

    // Average XP per user
    const avgXPResult = db.prepare(`
      SELECT AVG(xp) as avg FROM users WHERE xp > 0
    `).get();
    const avgXP = Math.round(avgXPResult?.avg || 0);

    // Total XP
    const totalXP = db.prepare('SELECT SUM(xp) as total FROM users').get().total || 0;

    res.json({
      totalUsers,
      activeUsers,
      goalsCompleted,
      avgXP,
      totalXP
    });
  } catch (error) {
    console.error('Overview error:', error);
    res.status(500).json({ error: 'Failed to fetch overview data' });
  }
});

// Get all users
router.get('/users', (req, res) => {
  try {
    const db = getDatabase();
    if (!db) {
      return res.status(500).json({ error: 'Database not available' });
    }

    const users = db.prepare(`
      SELECT 
        id, name, email, phone, age, gender, height, weight,
        xp, level, created_at
      FROM users
      ORDER BY created_at DESC
      LIMIT 100
    `).all();

    res.json(users);
  } catch (error) {
    console.error('Users error:', error);
    res.status(500).json({ error: 'Failed to fetch users' });
  }
});

// Get user details
router.get('/users/:id', (req, res) => {
  try {
    const db = getDatabase();
    if (!db) {
      return res.status(500).json({ error: 'Database not available' });
    }

    const user = db.prepare('SELECT * FROM users WHERE id = ?').get(req.params.id);
    
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    // Get user stats
    const today = new Date().toISOString().split('T')[0];
    
    const activity = db.prepare(`
      SELECT * FROM activity_tracking 
      WHERE user_email = ? AND date = ?
    `).get(user.email, today);

    const goals = db.prepare(`
      SELECT COUNT(*) as total,
             SUM(CASE WHEN is_completed = 1 THEN 1 ELSE 0 END) as completed
      FROM health_goals
      WHERE user_email = ?
    `).get(user.email);

    const sleep = db.prepare(`
      SELECT * FROM sleep_tracking 
      WHERE user_email = ? AND date = ?
    `).get(user.email, today);

    const water = db.prepare(`
      SELECT SUM(amount) as total FROM water_intake 
      WHERE user_email = ? AND date = ?
    `).get(user.email, today);

    res.json({
      user,
      stats: {
        activity: activity || null,
        goals: goals || { total: 0, completed: 0 },
        sleep: sleep || null,
        water: water?.total || 0
      }
    });
  } catch (error) {
    console.error('User details error:', error);
    res.status(500).json({ error: 'Failed to fetch user details' });
  }
});

// Get activity trends
router.get('/analytics/activity', (req, res) => {
  try {
    const db = getDatabase();
    if (!db) {
      return res.status(500).json({ error: 'Database not available' });
    }

    const days = parseInt(req.query.days) || 7;
    const startDate = new Date();
    startDate.setDate(startDate.getDate() - days);
    const startDateStr = startDate.toISOString().split('T')[0];

    const activity = db.prepare(`
      SELECT 
        date,
        AVG(steps) as avg_steps,
        AVG(active_minutes) as avg_active_minutes,
        AVG(calories_burned) as avg_calories,
        AVG(workout_duration) as avg_workout_duration,
        COUNT(DISTINCT user_email) as active_users
      FROM activity_tracking
      WHERE date >= ?
      GROUP BY date
      ORDER BY date ASC
    `).all(startDateStr);

    res.json(activity);
  } catch (error) {
    console.error('Activity analytics error:', error);
    res.status(500).json({ error: 'Failed to fetch activity analytics' });
  }
});

// Get sleep trends
router.get('/analytics/sleep', (req, res) => {
  try {
    const db = getDatabase();
    if (!db) {
      return res.status(500).json({ error: 'Database not available' });
    }

    const days = parseInt(req.query.days) || 7;
    const startDate = new Date();
    startDate.setDate(startDate.getDate() - days);
    const startDateStr = startDate.toISOString().split('T')[0];

    const sleep = db.prepare(`
      SELECT 
        date,
        AVG(duration_hours) as avg_duration,
        AVG(quality) as avg_quality,
        COUNT(DISTINCT user_email) as users_tracked
      FROM sleep_tracking
      WHERE date >= ?
      GROUP BY date
      ORDER BY date ASC
    `).all(startDateStr);

    res.json(sleep);
  } catch (error) {
    console.error('Sleep analytics error:', error);
    res.status(500).json({ error: 'Failed to fetch sleep analytics' });
  }
});

// Get water intake trends
router.get('/analytics/water', (req, res) => {
  try {
    const db = getDatabase();
    if (!db) {
      return res.status(500).json({ error: 'Database not available' });
    }

    const days = parseInt(req.query.days) || 7;
    const startDate = new Date();
    startDate.setDate(startDate.getDate() - days);
    const startDateStr = startDate.toISOString().split('T')[0];

    const water = db.prepare(`
      SELECT 
        date,
        SUM(amount) as total_intake,
        AVG(amount) as avg_intake,
        COUNT(DISTINCT user_email) as users_tracked
      FROM water_intake
      WHERE date >= ?
      GROUP BY date
      ORDER BY date ASC
    `).all(startDateStr);

    res.json(water);
  } catch (error) {
    console.error('Water analytics error:', error);
    res.status(500).json({ error: 'Failed to fetch water analytics' });
  }
});

// Get XP progression
router.get('/analytics/xp', (req, res) => {
  try {
    const db = getDatabase();
    if (!db) {
      return res.status(500).json({ error: 'Database not available' });
    }

    // Level distribution
    const levelDistribution = db.prepare(`
      SELECT 
        CASE 
          WHEN level <= 5 THEN '1-5'
          WHEN level <= 10 THEN '6-10'
          WHEN level <= 15 THEN '11-15'
          ELSE '16+'
        END as level_range,
        COUNT(*) as count
      FROM users
      WHERE level > 0
      GROUP BY level_range
      ORDER BY level_range
    `).all();

    // Top users by XP
    const topUsers = db.prepare(`
      SELECT name, email, xp, level
      FROM users
      ORDER BY xp DESC
      LIMIT 10
    `).all();

    res.json({
      levelDistribution,
      topUsers
    });
  } catch (error) {
    console.error('XP analytics error:', error);
    res.status(500).json({ error: 'Failed to fetch XP analytics' });
  }
});

// Get men workouts (CRUD)
router.get('/workouts', (req, res) => {
  try {
    const db = getDatabase();
    if (!db) {
      return res.status(500).json({ error: 'Database not available' });
    }

    const workouts = db.prepare(`
      SELECT DISTINCT 
        name, muscle_group, difficulty, duration, calories_burned
      FROM men_workouts
      GROUP BY name, muscle_group, difficulty, duration, calories_burned
      ORDER BY muscle_group, name
    `).all();

    res.json(workouts);
  } catch (error) {
    console.error('Workouts error:', error);
    res.status(500).json({ error: 'Failed to fetch workouts' });
  }
});

// Add workout template
router.post('/workouts', (req, res) => {
  try {
    const db = getDatabase();
    if (!db) {
      return res.status(500).json({ error: 'Database not available' });
    }

    const { name, muscleGroup, difficulty, duration, caloriesBurned } = req.body;

    if (!name || !muscleGroup || !difficulty || !duration || !caloriesBurned) {
      return res.status(400).json({ error: 'All fields required' });
    }

    // Insert as a template (no user_email, no date)
    const result = db.prepare(`
      INSERT INTO men_workouts (name, muscle_group, difficulty, duration, calories_burned, date, is_completed, user_email)
      VALUES (?, ?, ?, ?, ?, NULL, 0, NULL)
    `).run(name, muscleGroup, difficulty, duration, caloriesBurned);

    res.json({ success: true, id: result.lastInsertRowid });
  } catch (error) {
    console.error('Add workout error:', error);
    res.status(500).json({ error: 'Failed to add workout' });
  }
});

// Get health goals
router.get('/goals', (req, res) => {
  try {
    const db = getDatabase();
    if (!db) {
      return res.status(500).json({ error: 'Database not available' });
    }

    const goals = db.prepare(`
      SELECT 
        id, user_email, title, description, category, 
        target_value, current_value, deadline, is_completed, created_at
      FROM health_goals
      ORDER BY created_at DESC
      LIMIT 100
    `).all();

    res.json(goals);
  } catch (error) {
    console.error('Goals error:', error);
    res.status(500).json({ error: 'Failed to fetch goals' });
  }
});

// Update goal
router.put('/goals/:id', (req, res) => {
  try {
    const db = getDatabase();
    if (!db) {
      return res.status(500).json({ error: 'Database not available' });
    }

    const { title, description, category, target_value, deadline } = req.body;

    db.prepare(`
      UPDATE health_goals
      SET title = ?, description = ?, category = ?, target_value = ?, deadline = ?
      WHERE id = ?
    `).run(title, description, category, target_value, deadline, req.params.id);

    res.json({ success: true });
  } catch (error) {
    console.error('Update goal error:', error);
    res.status(500).json({ error: 'Failed to update goal' });
  }
});

// Delete goal
router.delete('/goals/:id', (req, res) => {
  try {
    const db = getDatabase();
    if (!db) {
      return res.status(500).json({ error: 'Database not available' });
    }

    db.prepare('DELETE FROM health_goals WHERE id = ?').run(req.params.id);

    res.json({ success: true });
  } catch (error) {
    console.error('Delete goal error:', error);
    res.status(500).json({ error: 'Failed to delete goal' });
  }
});

// Get AI insights summary
router.get('/insights', (req, res) => {
  try {
    const db = getDatabase();
    if (!db) {
      return res.status(500).json({ error: 'Database not available' });
    }

    // Get most common insights (if stored in database)
    // For now, return summary stats
    const waterGoal = db.prepare(`
      SELECT COUNT(*) as count
      FROM user_settings
      WHERE daily_water_goal IS NOT NULL
    `).get().count;

    const sleepGoal = db.prepare(`
      SELECT COUNT(*) as count
      FROM user_settings
      WHERE sleep_goal_hours IS NOT NULL
    `).get().count;

    res.json({
      waterGoalsSet: waterGoal,
      sleepGoalsSet: sleepGoal,
      insights: [
        { type: 'water', message: 'Most users need to increase water intake', priority: 'high' },
        { type: 'sleep', message: 'Sleep quality can be improved', priority: 'medium' },
        { type: 'activity', message: 'Daily activity goals are being met', priority: 'low' }
      ]
    });
  } catch (error) {
    console.error('Insights error:', error);
    res.status(500).json({ error: 'Failed to fetch insights' });
  }
});

module.exports = router;

