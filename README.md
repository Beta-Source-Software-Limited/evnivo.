# EVNIVO — Full-stack Event Ticket Booking Demo

A modern Next.js + TypeScript + Tailwind CSS event marketplace and Django REST Framework backend, with Django Admin, local database, login, ticket reservations, inventory tracking, and QR tickets.

**Important:** All events and booking confirmations are demonstrations. There is **no payment gateway**, financial settlement, organizer self-service permission model, real QR validation/check-in, or transactional email. Do not represent demo confirmations as paid orders or use this project in production without the security and business features listed below.

## Requirements
- Node.js 20.9+ (Node 22 recommended)
- Python 3.11+ (3.13 supported with recent dependencies)
- Optional MySQL 8+ (SQLite is default for easiest local development)

## 1. Backend (Terminal 1)

```bash
cd backend
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
python manage.py makemigrations events
python manage.py migrate
python manage.py seed_demo
python manage.py createsuperuser
python manage.py runserver 127.0.0.1:8000
```

Django Admin: http://127.0.0.1:8000/admin/  
REST API: http://127.0.0.1:8000/api/events/

**On Windows:** activate with `.venv\\Scripts\\activate` instead of `source`.

## 2. Frontend (Terminal 2)

```bash
cd frontend
cp .env.local.example .env.local
npm install
npm run dev
```

Open http://localhost:3000

## 3. Optional MySQL instead of SQLite

Create a MySQL database and a restricted local user:

```sql
CREATE DATABASE evnivo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'evnivo'@'localhost' IDENTIFIED BY 'choose-a-strong-password';
GRANT ALL PRIVILEGES ON evnivo.* TO 'evnivo'@'localhost';
```

First run `pip install -r requirements-mysql.txt` in the active virtual environment to enable the MySQL driver. Then in `backend/.env` set `DATABASE_URL=mysql://evnivo:YOUR_PASSWORD@127.0.0.1:3306/evnivo` (URL-encode special password characters), then run `python manage.py migrate` and `python manage.py seed_demo` for the MySQL DB. If the Mac lacks MySQL build headers for `mysqlclient`, install MySQL client libraries and `pkg-config` first, or stay on SQLite until you are ready.

## Admin content editing

- **Categories** — label and emoji icon
- **Events** — title, slug, description, banner upload/URL, location, dates, featured, publish status
- **Ticket types** — General/VIP pricing, capacity and status (nested under each Event)
- **Bookings / Tickets** — view reservations, demo status and ticket codes

Sample data is loaded by `seed_demo`. Dates are set in the future relative to the date you run the command. Re-running it adds missing records but doesn't overwrite events you edited.

## API routes

| Method | Route | Access |
|---|---|---|
| GET | `/api/categories/` | Public |
| GET | `/api/events/?search=&category=&city=&featured=true` | Public |
| GET | `/api/events/<slug>/` | Public |
| POST | `/api/auth/register/` | Public |
| POST | `/api/auth/login/` | Public |
| GET | `/api/auth/me/` | Token |
| GET, POST | `/api/bookings/` | Token |
| GET | `/api/tickets/<uuid>/qr/` | Owner token |

Example booking body: `{"ticket_type_id": 1, "quantity": 2}`. This **immediately creates a demo-confirmed reservation**. In a payment-enabled production implementation, reserve inventory temporarily and confirm only after a verified, idempotent payment webhook.

## Test

```bash
cd backend
source .venv/bin/activate
python manage.py test events
```

## Project layout

```
evnivo-source/
  backend/
    config/                   Django settings and URLs
    events/                   Database models, admin, APIs, seed, tests
    manage.py
    requirements.txt
  frontend/
    app/                      Next.js pages and styling
      events/[slug]/          Event details / ticket reservation
      login/ register/        Customer login and registration
      account/                Reservations and QR tickets
    components/               Navbar, EventCard, AuthForm, Footer
    lib/api.ts                Typed API helper and formatting
```

## Production checklist

1. Replace localStorage API token with short-lived authenticated sessions in HttpOnly Secure SameSite cookies; implement logout token revocation, rate limiting, password recovery, verification, and anti-bot protection.
2. Add a real payment gateway (SSLCommerz/bKash/Stripe), verify server-to-server webhooks with signatures and idempotency, and separate pending/paid/refunded/cancelled states.
3. Implement inventory holds with expiry, refund/cancellation rules, and transactional reconciliation.
4. Add staff-scoped organizer accounts and permissions so organizers cannot access other events or purchasers; Django staff currently have global admin permissions assigned by your superuser.
5. Build server-validated one-time QR check-in and a dedicated scanner UI; do **not** trust QR contents alone.
6. Add persistent object storage, email/SMS confirmations, monitoring, error reporting, image validation, backups, compliance, fraud controls, and accessibility tests.
7. Configure proper `DEBUG=False`, HTTPS, secure cookies, secret management, strict allowed origins/hosts, and deploy the Next.js and Django services independently.

## License

This source is provided for your own project use. External sample images are served from Unsplash and are not bundled. You can replace them with original event banners from Django Admin.


## Run with Docker Compose (Next.js + Django + MySQL)

Requires Docker Desktop for Mac (with Docker engine running). Run these from the folder containing `compose.yaml`:

```bash
cp .env.docker.example .env
docker compose up -d --build
docker compose logs -f backend
```

- Web app: http://localhost:3000
- Django admin: http://localhost:8000/admin/
- REST API: http://localhost:8000/api/events/

Create an admin user once the backend has started:

```bash
docker compose exec backend python manage.py createsuperuser
```

Stop containers without deleting data: `docker compose down`
Rebuild after source edits: `docker compose up -d --build`
View logs: `docker compose logs -f backend frontend db`
Remove containers **and all MySQL data/uploads**: `docker compose down -v` (destructive).

The Docker setup is intended for local development and a simple demonstration. It uses sample events, automatically applies Django migrations on backend startup, and builds the frontend using localhost API URLs. Before any public deployment, commit model migrations, use production secrets, HTTPS and a proper reverse proxy, configure hosts/CORS and persistent media, and integrate a real payment provider.
