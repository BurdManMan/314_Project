// Modal handling
var guestModal = document.getElementById('guestModal');
var organiserModal = document.getElementById('organiserModal');

// Close modals when clicking outside
window.onclick = function(event) {
  if (event.target == guestModal) {
    guestModal.style.display = "none";
  }
  if (event.target == organiserModal) {
    organiserModal.style.display = "none";
  }
}

// Handle guest login form submission
document.getElementById('login-g').addEventListener('submit', async function(e) {
  e.preventDefault(); // Allows manual handling of events
  const username = document.querySelector('#login-g #guest-username').value;
  const password = document.querySelector('#login-g #guest-password').value;

  try {
    const response = await fetch('http://localhost:5000/api/login', {
      method: 'POST',
      headers: {
        'Content-type' : 'application/json',
      },
      body: JSON.stringify({
        username,
        password,
        account_type: 'Customer'
      }),
    });

    const data = await response.json();
    if (data.token) {
      // Store the token and redirect
      // Storing a token so that site knows that the user is logged in
      localStorage.setItem('token', data.token);
      window.location.href = 'events.html';
    } else {
      alert('Login failed: ' + (data.message || 'Invalid credentials'));
    }
  } catch (error) {
    console.error('Login error:', error);
    alert('Login failed. Please try again')
  }
});

// Handle organizer login form submission
document.getElementById('login-o').addEventListener('submit', async function(e) {
  e.preventDefault(); // Allows manual handling of events
  const username = document.querySelector('#login-o #organiser-username').value;
  const password = document.querySelector('#login-o #organiser-password').value;

  try {
    const response = await fetch('http://localhost:5000/api/login', {
      method: 'POST',
      headers: {
        'Content-type' : 'application/json',
      },
      body: JSON.stringify({
        username,
        password,
        account_type: 'Organiser'
      }),
    });

    const data = await response.json();
    if (data.token) {
      // Store the token and redirect
      // Storing a token so that site knows that the user is logged in
      localStorage.setItem('token', data.token);
      window.location.href = 'organiser-dashboard.html';
    } else {
      alert('Login failed: ' + (data.message || 'Invalid credentials'));
    }
  } catch (error) {
    console.error('Login error:', error);
    alert('Login failed. Please try again')
  }
});

// Handle guest registration
document.querySelector('.guest-registration').addEventListener('submit', async function(e) {
  e.preventDefault(); // Allows manual handling of envents
  const formData = {
    account_name: e.target.elements['guest-name'].value,
    account_type: 'Customer',
    username: e.target.elements['guest-email'].value, // Using email as username
    password: e.target.elements['guest-psw'].value,
    name: e.target.elements['guest-name'].value,
    email: e.target.elements['guest-email'].value,
    phone: e.target.elements['guest-phone'].value
  };

  if (formData.password !== e.target.elements['guest-psw-repeat'].value) {
    alert('Passwords do not match!');
    return;
  }

  try {
    const response = await fetch('http://localhost:5000/api/register', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(formData),
    });

    const data = await response.json();
    if (response.ok) {
      alert('Registration successful! Please login.');
      guestModal.style.display = 'none';
    } else {
      alert('Registration failed: ' + (data.message || 'Unknown error'));
    }
  } catch (error) {
    console.error('Registration error: ', error);
    alert('Registration failed. Please try again.');
  }
});

// Handle organizer registration
document.querySelector('.organiser-registration').addEventListener('submit', async function(e) {
  e.preventDefault();
  const formData = {
    account_name: e.target.elements['organiser-name'].value,
    account_type: 'Organiser',
    username: e.target.elements['organiser-email'].value,
    password: e.target.elements['organiser-psw'].value,
    name: e.target.elements['organiser-name'].value,
    email: e.target.elements['organiser-email'].value,
    phone: e.target.elements['organiser-phone'].value,
    company_name: e.target.elements['organiser-company-name'].value
  };
  
  if (formData.password !== e.target.elements['organiser-psw-repeat'].value) {
    alert('Passwords do not match!');
    return;
  }
  
  try {
    const response = await fetch('http://localhost:5000/api/register', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(formData),
    });
    
    const data = await response.json();
    if (response.ok) {
      alert('Registration successful! Please login.');
      organiserModal.style.display = 'none';
    } else {
      alert('Registration failed: ' + (data.message || 'Unknown error'));
    }
  } catch (error) {
    console.error('Registration error:', error);
    alert('Registration failed. Please try again.');
  }
});