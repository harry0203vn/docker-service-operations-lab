# Operations

`scripts/service_control.sh` is a thin, safe wrapper around `docker compose` for the `nordstern-webportal` service. It always resolves the project directory relative to its own location, so it works no matter which directory it is invoked from.

## Commands

```
./scripts/service_control.sh {start|stop|status|logs}
```

| Command | What it does | Underlying Compose call |
|---|---|---|
| `start` | Starts the service in the background. | `docker compose -f docker-compose.yml up -d` |
| `stop` | Stops and removes the service's container. | `docker compose -f docker-compose.yml down` |
| `status` | Shows whether the container is currently running. | `docker compose -f docker-compose.yml ps` |
| `logs` | Prints the last 50 lines of the container's logs. | `docker compose -f docker-compose.yml logs --tail=50` |

Running the script with no argument, or an unrecognized one, prints a usage message and exits with status `1`; it never starts or stops anything in that case.

## Start

```bash
./scripts/service_control.sh start
```

Starts the `nordstern-webportal` container via Docker Compose. Once running, the portal is reachable at **http://localhost:8090**.

## Stop

```bash
./scripts/service_control.sh stop
```

Stops and removes the container (`docker compose down`). The static content in `webportal/` is untouched, since it lives on the host and is only mounted read-only.

## Status

```bash
./scripts/service_control.sh status
```

Shows the current container status (running / stopped) via `docker compose ps`.

## Logs

```bash
./scripts/service_control.sh logs
```

Shows the last 50 lines of the container's own logs (Nginx access/error output), useful when the health check reports a failure and the actual cause needs to be investigated inside the container.

## Safety behavior

Before running any Compose command, the script checks that `docker-compose.yml` actually exists at the resolved project path. If it is missing, the script prints a clear error message naming the expected path and exits with status `1` instead of failing with a raw Docker error.
