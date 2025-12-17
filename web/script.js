// ============================================================================
// SEHATI - Landing Page & Admin Dashboard JavaScript
// ============================================================================

// Theme Management
function toggleTheme() {
  const body = document.body;
  const themeIcon = document.querySelector('.theme-icon');
  
  if (body.classList.contains('light-mode')) {
    body.classList.remove('light-mode');
    body.classList.add('dark-mode');
    themeIcon.textContent = '☀️';
    localStorage.setItem('theme', 'dark');
  } else {
    body.classList.remove('dark-mode');
    body.classList.add('light-mode');
    themeIcon.textContent = '🌙';
    localStorage.setItem('theme', 'light');
  }
}

// Load saved theme
function loadTheme() {
  const savedTheme = localStorage.getItem('theme') || 'light';
  const body = document.body;
  const themeIcon = document.querySelector('.theme-icon');
  
  body.classList.remove('light-mode', 'dark-mode');
  body.classList.add(savedTheme + '-mode');
  
  if (themeIcon) {
    themeIcon.textContent = savedTheme === 'dark' ? '☀️' : '🌙';
  }
}

// Mobile Menu
function toggleMobileMenu() {
  const mobileMenu = document.getElementById('mobileMenu');
  mobileMenu.classList.toggle('active');
}

// Close mobile menu when clicking a link
document.querySelectorAll('.mobile-menu a').forEach(link => {
  link.addEventListener('click', () => {
    document.getElementById('mobileMenu').classList.remove('active');
  });
});

// Smooth scroll for anchor links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
  anchor.addEventListener('click', function (e) {
    e.preventDefault();
    const target = document.querySelector(this.getAttribute('href'));
    if (target) {
      target.scrollIntoView({
        behavior: 'smooth',
        block: 'start'
      });
    }
  });
});

// Navbar scroll effect
window.addEventListener('scroll', () => {
  const navbar = document.querySelector('.navbar');
  if (window.scrollY > 50) {
    navbar.style.boxShadow = '0 2px 10px var(--shadow)';
  } else {
    navbar.style.boxShadow = 'none';
  }
});

// Animation on scroll
function animateOnScroll() {
  const elements = document.querySelectorAll('.feature-card, .testimonial-card, .stat-card');
  
  elements.forEach(element => {
    const elementTop = element.getBoundingClientRect().top;
    const windowHeight = window.innerHeight;
    
    if (elementTop < windowHeight - 100) {
      element.style.opacity = '1';
      element.style.transform = 'translateY(0)';
    }
  });
}

// Initialize animations
function initAnimations() {
  const elements = document.querySelectorAll('.feature-card, .testimonial-card, .stat-card');
  
  elements.forEach(element => {
    element.style.opacity = '0';
    element.style.transform = 'translateY(20px)';
    element.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
  });
  
  // Trigger initial check
  animateOnScroll();
}

// Counter animation for stats
function animateCounters() {
  const counters = document.querySelectorAll('.stat-value, .stat-card-value');
  
  counters.forEach(counter => {
    const target = counter.textContent;
    const numericValue = parseFloat(target.replace(/[^0-9.]/g, ''));
    const suffix = target.replace(/[0-9.,]/g, '');
    
    if (!isNaN(numericValue)) {
      let current = 0;
      const increment = numericValue / 50;
      const timer = setInterval(() => {
        current += increment;
        if (current >= numericValue) {
          current = numericValue;
          clearInterval(timer);
        }
        
        if (numericValue >= 1000) {
          counter.textContent = Math.floor(current).toLocaleString() + suffix;
        } else if (Number.isInteger(numericValue)) {
          counter.textContent = Math.floor(current) + suffix;
        } else {
          counter.textContent = current.toFixed(1) + suffix;
        }
      }, 30);
    }
  });
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', () => {
  loadTheme();
  initAnimations();
  
  // Start counter animation when stats are visible
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        animateCounters();
        observer.disconnect();
      }
    });
  });
  
  const statsSection = document.querySelector('.hero-stats') || document.querySelector('.stats-grid');
  if (statsSection) {
    observer.observe(statsSection);
  }
});

window.addEventListener('scroll', animateOnScroll);

// ============================================================================
// ADMIN DASHBOARD SPECIFIC
// ============================================================================

// Sample data for charts (placeholder for real data integration)
const sampleData = {
  users: {
    total: 10542,
    active: 3287,
    growth: '+12.5%'
  },
  goals: {
    completed: 45892,
    pending: 12453
  },
  xp: {
    average: 1250,
    total: 13177500
  },
  activity: {
    steps: [8500, 7200, 9100, 6800, 8900, 7500, 8200],
    water: [2.1, 1.8, 2.3, 2.0, 1.9, 2.2, 2.0],
    sleep: [7.5, 6.8, 7.2, 8.0, 7.1, 6.5, 7.8]
  }
};

// Initialize admin dashboard if on admin page
function initAdminDashboard() {
  if (!document.querySelector('.admin-layout')) return;
  
  // Update stats cards with sample data
  updateStatsCards();
  
  // Initialize charts placeholder
  initCharts();
  
  // Set up sidebar navigation
  setupSidebarNav();
}

function updateStatsCards() {
  // This would be replaced with real API calls
  console.log('Admin dashboard initialized with sample data');
}

function initCharts() {
  // Placeholder for chart initialization
  // In production, use Chart.js or similar library
  const chartPlaceholders = document.querySelectorAll('.chart-placeholder');
  chartPlaceholders.forEach(placeholder => {
    placeholder.innerHTML = `
      <div style="text-align: center;">
        <div style="font-size: 48px; margin-bottom: 8px;">📊</div>
        <p>Chart visualization ready for data integration</p>
      </div>
    `;
  });
}

function setupSidebarNav() {
  const sidebarLinks = document.querySelectorAll('.sidebar-link');
  
  sidebarLinks.forEach(link => {
    link.addEventListener('click', (e) => {
      // Remove active class from all links
      sidebarLinks.forEach(l => l.classList.remove('active'));
      // Add active class to clicked link
      link.classList.add('active');
    });
  });
}

// Search functionality for user table
function searchUsers(query) {
  const rows = document.querySelectorAll('.data-table tbody tr');
  const lowerQuery = query.toLowerCase();
  
  rows.forEach(row => {
    const text = row.textContent.toLowerCase();
    row.style.display = text.includes(lowerQuery) ? '' : 'none';
  });
}

// Export functionality
function exportData(format) {
  // Placeholder for export functionality
  alert(`Exporting data as ${format}... (Integration pending)`);
}

// Initialize admin features
document.addEventListener('DOMContentLoaded', initAdminDashboard);

