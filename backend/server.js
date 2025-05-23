const express = require('express');
const bodyParser = require('body-parser'); // Allows for reading of JSON body text.
const cors = require('cors'); // Allows backend API to be accessed from different domains.
const db = require('./db'); // Connects to database and provides easy query functionaility.
const path = require('path');

const app = express();
app.use(cors());
app.use(bodyParser.json()); // Handles JSON
app.use(bodyParser.urlencoded({ extended: true})); // Handles form submissions

// Serve static files from the frontend directory
app.use(express.static(path.join(__dirname, '../frontend')));

// Login endpoint 
app.post('/api/login', async (req, res) => {
    const { username, password, account_type } = req.body;

    try {
        // Find user in database
        const { rows } = await db.query(
            'SELECT * FROM site_user WHERE username = $1 AND account_type = $2',
            [username, account_type]
        );

        if (rows.length === 0) {
            return res.status(401).json({ error: 'User not found' });
        }

        const user = rows[0];

        // Compare passwords
        if (password !== user.password) {
            return res.status(401).json({ error: 'Invalid credentials '});
        }

        res.json({
            token: 'dummy-token', // This is to save who is logged in 
            user: {
                id: user.site_user_id,
                type: user.account_type
            }
        });

    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Login failed' });
    }
});

// User registration endpoint
app.post('/api/register', async (req, res) => {
    const { account_name, account_type, username, password, name, email } = req.body;

    try {
        // Start transaction
        await db.query('BEGIN');

        // Insert into site_user
        const userQuery = `
            INSERT INTO site_user(account_name, account_type, username, password)
            VALUES($1, $2, $3, $4) RETURNING site_user_id`;
        const userValues = [account_name, account_type, username, password];
        const { rows: userRows } = await db.query(userQuery, userValues);

        // Insert into customer or organiser based on account_type
        if (account_type === 'Customer') {
            await db.query(
                'INSERT INTO customer(site_user_id, name, email) VALUES($1, $2, $3)',
                [userRows[0].site_user_id, name, email]
            );
        }

        await db.query('COMMIT');
        res.status(201).json({ success: true });
    } catch (err) {
        await db.query('ROLLBACK');
        console.error(err);
        res.status(500).json({ error: 'Registration failed' });
    }
});

// More endpoints here...

// Serve the home page
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '../frontend/home-page.html'));
});

const PORT = 5000;

app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`)
});