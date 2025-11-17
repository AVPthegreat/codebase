# ✅ OnlineJudge Setup Complete

## 🎉 Your system is fully configured and ready to use!

All permanent fixes have been applied:

### ✅ What's Fixed

1. **Docker Compose Configuration**
   - All services properly networked
   - Correct container names used for internal communication
   - Judge server can reach backend at `http://oj-app:8000`
   - Persistent volumes configured for data

2. **Test Cases Restored**
   - Test case files created for all problems
   - Proper directory structure in `OnlineJudge/data/test_case/`
   - Correct permissions set (755 for directories, 644 for files)
   - Info files configured correctly

3. **Judge Server Fixed**
   - Environment variables set correctly
   - Log directory mounted at `/log`
   - Judger run directory mounted at `/judger`
   - Test cases accessible at `/test_case` (read-only)
   - Heartbeat working with backend

4. **Backend Configuration**
   - Database connection working
   - Redis connected
   - Dramatiq workers running for async judge tasks
   - API endpoints responding

5. **Frontend Working**
   - Development server running
   - Proxy configured to backend
   - Accessible at http://localhost:8080

### 📁 Persistent Data Locations

All data persists across restarts in `OnlineJudge/data/`:
```
OnlineJudge/data/
├── postgres/           # Database (DO NOT DELETE!)
├── test_case/          # Problem test cases
│   ├── 8440a0dd.../   # Problem 1 (Hello Codebase)
│   │   ├── 1.in
│   │   ├── 1.out
│   │   └── info
│   └── 36801126.../   # Problem 2 (Sum of Large Numbers)
│       ├── 1.in, 1.out
│       ├── 2.in, 2.out
│       ├── 3.in, 3.out
│       └── info
├── log/                # Application logs
│   └── judge-server/
├── judger-run/         # Judge temporary files
└── backups/            # Database backups
```

### 🚀 Starting the System (Every Time)

**Option 1: Use the startup script (Recommended)**
```bash
./startup.sh
```

**Option 2: Manual start**
```bash
docker compose up -d
```

**Option 3: Start with rebuild**
```bash
docker compose up -d --build
```

### 🔗 Access URLs

- **Frontend:** http://localhost:8080
- **Backend API:** http://localhost:8000/api/
- **Admin Login:** http://localhost:8080/admin

### 🔑 Credentials

**Super Admin:**
- Username: `root`  
- Password: `rootroot`

**Test User:**
- Username: `testuser`
- Password: `testpass`

### 📊 Verify Everything Works

Run the startup script to verify all services:
```bash
./startup.sh
```

Should show:
- ✅ Backend API is responding
- ✅ Frontend is responding  
- ✅ Judge server is running
- ✅ Found test case files

### 🧪 Test Judging System

1. Open http://localhost:8080
2. Login as root/rootroot
3. Go to "Problems" 
4. Try "Hello Codebase" (CB101)
5. Submit this solution:

```c
#include <stdio.h>
int main() {
    printf("Welcome to Codebase Online Judge!\n");
    return 0;
}
```

6. Should get result: **Accepted** (AC)

### 🛠️ Troubleshooting

**If judging fails:**
```bash
# Check judge server logs
docker logs oj-judge-server --tail 50

# Verify test cases exist
ls -la OnlineJudge/data/test_case/*/

# Fix permissions if needed
chmod -R 755 OnlineJudge/data/test_case
```

**If backend not responding:**
```bash
# Check backend logs
docker logs oj-app --tail 50

# Restart backend
docker compose restart backend
```

**If containers not starting:**
```bash
# Check what's running
docker ps -a

# View all logs
docker compose logs --tail=100

# Full restart
docker compose down
docker compose up -d
```

### 🔄 Stopping the System

```bash
# Stop all containers (data persists)
docker compose down

# Stop and remove volumes (DELETES ALL DATA!)
docker compose down -v
```

### 💾 Backup Your Data

**Database backup:**
```bash
docker exec oj-postgres pg_dump -U onlinejudge onlinejudge > backup-$(date +%F).sql
```

**Test cases backup:**
```bash
tar -czf test_cases_backup.tar.gz OnlineJudge/data/test_case/
```

### 📝 Configuration Files

- `docker-compose.yml` - Service definitions (persistent)
- `.env` - Environment variables (persistent)
- `.env.example` - Template for .env
- `startup.sh` - Startup verification script
- `README-persistence.md` - Data persistence guide

### 🎯 What to Do Next

1. **Change default passwords** in admin panel
2. **Add more problems** via admin panel  
3. **Upload test cases** for new problems
4. **Create contests** if needed
5. **Configure website settings** in admin panel

### ⚠️ Important Notes

1. **Never delete** `OnlineJudge/data/postgres/` - this is your database!
2. **Test case permissions** must be 755/644 or judge will fail
3. **Judge server token** should match between backend and judge-server
4. **Restart containers** to apply .env changes: `docker compose up -d`

### 🎊 You're All Set!

Everything is configured to persist across restarts. Just run:
```bash
./startup.sh
```

And your Online Judge will be up and running!

---

**Last Updated:** November 17, 2025  
**Status:** ✅ Production Ready
