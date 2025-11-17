# Persistence & docker-compose (local dev)

This README explains how to run the full stack of the OnlineJudge project locally using docker-compose, how persistence is configured, and how to back up the Postgres database.

Quick start

1. Copy `.env.example` to `.env` and edit values if needed.
2. Bring up the stack:

```bash
docker compose up -d --build
```

Services started
- postgres (container: `oj-postgres`) — Postgres data is persisted under `./OnlineJudge/data/postgres` on the host.
- redis (container: `oj-redis`)
- backend (container: `oj-app`)
- frontend (container: `oj-fe`)
- judge-server (container: `oj-judge-server`)

Backups

Create a SQL dump of the database and save it under `OnlineJudge/data/backups`:

```bash
mkdir -p OnlineJudge/data/backups
docker exec -t oj-postgres pg_dump -U ${POSTGRES_USER:-onlinejudge} ${POSTGRES_DB:-onlinejudge} > OnlineJudge/data/backups/backup-$(date +%F_%H%M).sql
```

Notes

- The compose file mounts the host `./OnlineJudge` directory into the backend container at `/app`. This makes code changes visible to the container during development.
- If you remove the Postgres container but keep the `./OnlineJudge/data/postgres` directory, your data will persist and will be reused by a new Postgres container started by docker-compose.
- To fully reproducibly run the stack on another machine, copy the `OnlineJudge/data/postgres` directory (or a SQL dump) and the `.env` file.

Security

- The `.env.example` uses a weak default password for convenience. For production, change `POSTGRES_PASSWORD` and other secrets.
# Persistence & docker-compose for this project

This file describes the docker-compose setup for running the OnlineJudge stack locally with persistent storage.

Files added:
- `docker-compose.yml` — defines services: `postgres`, `redis`, `backend` (oj-app), `frontend` (oj-fe), `judge` (oj-judge-server)
- `.env.example` — example environment variables

Persistence conventions used:
- Host path `./OnlineJudge/data/postgres` is mounted into the Postgres container at `/var/lib/postgresql/data` so the database files are kept on disk across restarts.
- Host path `./OnlineJudge/data` is mounted into the backend at `/data` to preserve uploads, SSL, config, testcases, and other runtime artifacts.

Quick start (from repo root):

1. Copy the `.env.example` to `.env` and set any secrets you prefer:

```bash
cp .env.example .env
# edit .env to set a stronger POSTGRES_PASSWORD and JUDGE_SERVER_TOKEN for production
```

2. Create the backups directory (compose won't create this automatically):

```bash
mkdir -p OnlineJudge/data/backups
```

3. Bring up the stack:

```bash
docker compose up -d
```

4. Verify:

```bash
docker ps
curl -sS http://127.0.0.1:8080/api/website | jq .
```

Notes & safety
- The `docker-compose.yml` uses the existing `oj-network` Docker network (it sets `external: true`). If you don't have `oj-network`, the compose command will fail — create the network with `docker network create oj-network` or change the compose file to create it internally.
- I recommend rotating the DB password and saving backups (pg_dump) regularly.
## Persistent Environment & Data Safety

This document explains how the judge stack (backend, frontend, PostgreSQL, Redis) is started with Docker Compose so your data (problems, contests, users, submissions) is preserved across restarts and deployments.

### Components
| Service    | Purpose                                   | Port |
|----------- |-------------------------------------------|------|
| postgres   | Primary database (persistent)             | 5435 (host) |
| redis      | Cache / broker                            | 6380 (host) |
| backend    | Django + gunicorn + static (judge API)    | 8000 |
| frontend   | Vue dev server (proxying to backend)      | 8080 |

### Persistence Layout
```
./OnlineJudge/data/                # Mounted to /data inside backend (uploads, avatars, test cases, config)
./OnlineJudge/data/postgres/       # Bound to /var/lib/postgresql/data in postgres (DB files)
```

Your database content lives under `./OnlineJudge/data/postgres`. Back it up regularly.

### Start / Stop
```
docker compose up -d --build   # build images (first time) and start all services
docker compose ps              # show running services
docker compose logs -f backend # tail backend logs
docker compose down            # stop (data preserved because of bind mounts)
```

### First Run Initialization
The backend entrypoint automatically:
1. Generates `data/config/secret.key` if missing.
2. Applies migrations with retries.
3. Creates the super admin `root` (password `rootroot`) if it doesn't exist.
4. Sets `SysOptions.judge_server_token` to `JUDGE_SERVER_TOKEN` from `.env`.

### Changing Admin Password
```
docker compose exec backend python manage.py changepassword root
```

### Backing Up the Database
```
docker compose exec postgres pg_dump -U onlinejudge onlinejudge > backup.sql
```

Automate with cron (example macOS/Linux):
```
0 3 * * * cd /path/to/codebase && docker compose exec postgres pg_dump -U onlinejudge onlinejudge > backups/`date +\%Y\%m\%d`-oj.sql
```

### Restoring a Backup
```
cat backup.sql | docker compose exec -T postgres psql -U onlinejudge onlinejudge
```

### Switching Environments
Environment is controlled by `OJ_ENV` in `.env`.
Set `OJ_ENV=production` (already default) to use Postgres; for quick local tinkering with SQLite you could adjust `OJ_ENV=dev` and comment out POSTGRES_* vars, but that splits data. Recommended: keep Postgres for consistency.

### Avoiding Data Loss
1. Do not start random standalone containers; always use `docker compose` so volumes are consistent.
2. Commit migrations before deployment: `docker compose exec backend python manage.py makemigrations && python manage.py migrate`.
3. Back up `./OnlineJudge/data/postgres` or use pg_dump before upgrades.
4. Keep `.env` safe (tokens & passwords). Never commit secrets for production.

### Judge Server Token
Stored in `SysOptions.judge_server_token`. Change by editing `.env` and re-running `docker compose up -d` (backend restart); token updates on startup.

### Frontend
Dev server proxied via `TARGET=http://backend:8000`. For production builds you can rely on the dist assets already baked into the backend image (it downloads a pre-built `dist.zip` in its Dockerfile). Optional: create a separate prod build process to replace that with a locally built dist.

### Quick Diagnostics
```
curl -s http://127.0.0.1:8000/api/website
curl -s "http://127.0.0.1:8080/api/contests?offset=0&limit=5"
docker compose exec backend python manage.py shell -c "from problem.models import Problem; print(Problem.objects.count())"
```

### Common Issues
| Symptom | Cause | Fix |
|---------|-------|-----|
| Empty problem set | Pointed to new DB / missing mount | Ensure compose & Postgres bind present |
| Cannot login as root | Different DB or password changed | Run changepassword command |
| Duplicate column migration error | Migration already applied in DB | Use `--fake` or adjust migration history |

### Production Deployment Notes
1. Use a managed Postgres instance instead of local bind mount; adjust POSTGRES_HOST.
2. Add reverse proxy (nginx / traefik) TLS termination instead of exposing container port directly.
3. Set strong, unique credentials in `.env` and DO NOT commit production `.env`.
4. Add scheduled backups and monitoring.

### Next Steps
- Add a backup script (`deploy/backup.sh`) if needed.
- Add health endpoint in Django if deeper checks required.
- Integrate problem export/import management commands for easier migration.

---
Last updated: 2025-11-08
