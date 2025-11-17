
# Nexus Code by avpthegreat

Welcome to **Nexus Code**, a startup idea by avpthegreat. Nexus Code is a next-generation online judge platform designed to gamify the coding experience and offer SaaS solutions to colleges and universities. Our mission is to help institutions transition from pen-and-paper CS exams to a modern, engaging, and fair digital environment for students.

---
## Branding & Startup Vision
**Nexus Code** is powered by avpthegreat. Our vision is to:
- Gamify the coding experience for students and professionals
- Offer SaaS to colleges for digital CS exams, replacing pen-and-paper with a better, fairer, and more engaging platform
- Provide real-time proctoring, contest management, and automated feedback

---

## Features

- **Contest Types:**
  - **ACM (ICPC):** Only fully correct solutions are accepted (AC). No partial credit.
  - **OI (Olympiad):** Partial scoring per test case. Each passed test case earns points.
- **Submission Results:**
  - **AC (Accepted):** Solution passed all test cases.
  - **WA (Wrong Answer):** Solution failed at least one test case.
  - **PC (Partial Correct):** (OI only) Some test cases passed, some failed.
- **User Authentication:**
  - Registration, login, password reset, and email verification.
  - Two-factor authentication (2FA) support.
- **Proctoring:**
  - Fullscreen enforcement during contests.
  - Tracks and warns on fullscreen exits; auto-submits after repeated violations.
  - Admin panel for real-time monitoring.
- **Contest Result Emails:**
  - After contest ends, users receive a summary of their results via email.
- **Admin Tools:**
  - Contest management, announcements, user management, and bulk result mailing.
- **Extensible API:**
  - RESTful endpoints for all major actions.

---

## How It Works

### Contest Flow
1. **User registers and verifies email.**
2. **User joins a contest (ACM or OI).**
3. **Submits solutions:**
   - ACM: Only AC counts.
   - OI: Partial scores possible.
4. **Proctoring active:**
   - Must stay in fullscreen.
   - Exiting fullscreen triggers warnings and is logged.
5. **After contest:**
   - Results are emailed to participants.
   - Admin can view all attempts and violations.

### Email Services
- **Authentication:**
  - Email verification after registration.
  - Password reset emails.
- **Contest Results:**
  - Automated summary sent to each participant after contest.

---

## Quick Start Guide

### Step 1: Install Backend Dependencies
```bash
cd OnlineJudge
python3 -m venv venv
source venv/bin/activate
pip install -r deploy/requirements.txt
```

### Step 2: Run Database Migrations
```bash
python3 manage.py makemigrations
python3 manage.py migrate
```

### Step 3: Create Super Admin
```bash
python3 manage.py createsuperuser
```
Follow prompts to set username, email, and password.

### Step 4: Start Backend Server
```bash
python3 manage.py runserver 0.0.0.0:8000
```
Backend will run at `http://localhost:8000`

### Step 5: Start Frontend (in new terminal)
```bash
cd ../OnlineJudgeFE
npm install
npm run dev
```
Frontend will run at `http://localhost:8080`

### Step 6: Start Dramatiq Worker (in new terminal, for emails)
```bash
cd OnlineJudge
source venv/bin/activate
python3 -m dramatiq account.tasks
```

---

## SMTP Setup (Enable Emails)

### Option 1: Using Gmail (Recommended for Testing)

1. **Enable 2-Step Verification** in your Google Account
2. **Generate App Password:**
   - Go to https://myaccount.google.com/apppasswords
   - Select "Mail" and "Other (Custom name)"
   - Copy the 16-character password

3. **Configure in Admin Panel:**
   - Login at `http://localhost:8080/admin`
   - Navigate to **System** → **Configuration**
   - Fill in SMTP settings:
   ```
   Server: smtp.gmail.com
   Port: 587
   Email: your-email@gmail.com
   Password: [16-character app password]
   TLS: ✓ Enable
   ```
   - Click **Save**
   - Click **Test Email** to verify

### Option 2: Using Other SMTP Providers

**Outlook/Hotmail:**
```
Server: smtp-mail.outlook.com
Port: 587
TLS: Enabled
```

**Yahoo Mail:**
```
Server: smtp.mail.yahoo.com
Port: 587
TLS: Enabled
```

**SendGrid:**
```
Server: smtp.sendgrid.net
Port: 587
Email: apikey
Password: [your SendGrid API key]
TLS: Enabled
```

### Option 3: Using API (for programmatic setup)

```bash
curl -X POST http://localhost:8000/api/admin/conf/smtp/ \
  -H "Content-Type: application/json" \
  -d '{
    "server": "smtp.gmail.com",
    "port": 587,
    "email": "your-email@gmail.com",
    "password": "your-app-password",
    "tls": true
  }'
```

---

## Complete Usage Guide

### For Admins:

1. **Login** at `http://localhost:8080/admin`
2. **Configure SMTP** (see above)
3. **Create a Contest:**
   - Go to **Contest** → **Create Contest**
   - Set title, start/end time, type (ACM/OI)
   - Add problems
4. **Add Problems:**
   - Go to **Problem** → **Create Problem**
   - Upload test cases
5. **Monitor Contestants:**
   - View real-time proctoring data
   - Check submissions and rankings
6. **Send Contest Results:**
   - After contest ends, go to contest page
   - Click "Send Result Emails" to notify all participants

### For Students/Users:

1. **Register** at `http://localhost:8080/register`
2. **Verify Email** (check inbox for verification link)
3. **Browse Contests** at `http://localhost:8080/contests`
4. **Join Contest:**
   - Click on contest
   - Enter password if required
   - Click "Start Contest"
5. **Enter Fullscreen Mode** (required for proctored contests)
6. **Submit Solutions:**
   - Read problem
   - Write code
   - Submit
7. **View Results** after contest ends (emailed to you)

---

## Troubleshooting

### Emails not sending?
- Check SMTP config in admin panel
- Verify app password is correct (not regular password)
- Check Dramatiq worker is running
- Look at backend terminal for error logs

### Can't login to admin?
- Make sure you created superuser (Step 3)
- Default URL: `http://localhost:8080/admin`

### Frontend not loading?
- Check if npm install completed
- Verify backend is running on port 8000
- Try `npm run dev` again

### Database errors?
- Run migrations again: `python3 manage.py migrate`
- Delete `db.sqlite3` and start fresh if needed

---

## API Endpoints (Highlights)
- `/api/register` — User registration
- `/api/verify_email` — Email verification
- `/api/apply_reset_password` — Request password reset
- `/api/contest/start` — Start contest
- `/api/contest/stop` — Stop contest
- `/api/contest/proctor` — Log proctoring events
- `/api/admin/contest/send_results` — Admin: send contest result emails


---

## File Structure Overview
- `OnlineJudge/` — Django backend
  - `account/` — User management, authentication, email
  - `contest/` — Contest logic, attempts, proctoring
  - `utils/mail.py` — Email utilities
  - `account/templates/` — Email HTML templates
- `OnlineJudgeFE/` — Frontend (Vue.js)

---

## Contact & Support
For issues, feature requests, or support, contact the **avpthegreat** team.

---


## License
**Proprietary – All rights reserved.**

This software and its source code are proprietary to avpthegreat and Nexus Code. Unauthorized copying, distribution, modification, or use of this software, in whole or in part, is strictly prohibited.

This software is provided for demonstration and evaluation purposes only. Commercial use, redistribution, or deployment is not permitted without explicit written permission from avpthegreat.

For licensing inquiries, partnership, or SaaS offerings, contact avpthegreat directly.

---

## Credits
Developed and maintained by **avpthegreat** for Nexus Code.
