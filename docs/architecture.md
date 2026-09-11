# Architecture

## Overview

The project runs a single containerized service defined entirely through Docker Compose — no custom `Dockerfile` is used, only the official `nginx:alpine` image.

```yaml
services:
  webportal:
    image: nginx:alpine
    container_name: nordstern-webportal
    ports:
      - "8090:80"
    volumes:
      - ./webportal:/usr/share/nginx/html:ro
    restart: unless-stopped
```

## Components

| Component | Role |
|---|---|
| `docker-compose.yml` | Declares the single `webportal` service, its image, port mapping, volume, and restart policy. |
| `nordstern-webportal` container | An `nginx:alpine` container serving static files. This is the only container in the project. |
| `webportal/` | Static site content (`index.html`, `style.css`) for a small fictional company portal, mounted **read-only** into the container. |
| `scripts/service_control.sh` | Bash wrapper around `docker compose` for starting, stopping, and inspecting the service. |
| `scripts/health_check.sh` | Bash script that probes the running service over HTTP and logs the result. |
| `scripts/report_generator.py` | Python script that turns the health-check log into a short operational report. |
| `logs/healthcheck.log` | Append-only log written by `health_check.sh`. |
| `reports/betriebsreport.txt` | Generated report written by `report_generator.py`. |

## Data / control flow

```
service_control.sh start
        │
        ▼
docker compose up -d  ──►  nordstern-webportal (nginx:alpine)
                                   │  listens on container port 80
                                   │  serves ./webportal (read-only)
                                   ▼
                         http://localhost:8090  (host port 8090 -> container port 80)

health_check.sh  ──HTTP GET──►  http://localhost:8090
        │
        ▼
appends "<timestamp> OK" or "<timestamp> FEHLER" to logs/healthcheck.log

report_generator.py  ──reads──►  logs/healthcheck.log
        │
        ▼
writes reports/betriebsreport.txt (OK/FEHLER counts, last status, recommendation)
```

## Design decisions

- **Official image only, no custom `Dockerfile`.** The service only needs to serve static files, so `nginx:alpine` is used directly. This keeps the image small and avoids maintaining a custom build.
- **Read-only bind mount.** `./webportal:/usr/share/nginx/html:ro` mounts the site content read-only, so the running container cannot modify the source files on the host.
- **`restart: unless-stopped`.** The container restarts automatically after a host reboot or Docker restart, but stays stopped if it was deliberately stopped via `service_control.sh stop`.
- **No custom Docker network.** With a single service, Compose's default network is sufficient; no service-to-service communication is required.
- **Separation of concerns.** Compose owns the container lifecycle, `service_control.sh` is the human-facing operational entry point, `health_check.sh` handles monitoring, and `report_generator.py` handles reporting — each script has one job.
