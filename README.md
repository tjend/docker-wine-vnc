# Run a Wine application in Docker and Access via VNC

This repo runs a Wine application in docker and and makes it accessible via VNC.

## Initial Setup

After checking out the git repo, copy `.env.example` to `.env` and edit as appropriate.

Then run `make docker-compose-build` and `make docker-compose-up`, and connect via VNC.

`make` is used to run all commands:

```shell
$ make
docker-compose-build:  run docker compose build
docker-compose-down:   run docker compose down
docker-compose-up:     run docker compose up
help:                  list all make commands
shell_exec:            run debugging shell in running container (after docker-compose-up)
shell_run:             run debugging shell (without docker-compose-up)
```

## Helpful Wrapper Script

This is a sample wrapper script to start, run and stop the application.

```shell
#!/bin/sh

cd ~/dev/docker-wine-vnc
# start container
make docker-compose-up &
sleep 4
# connect via vnc
remmina -c vnc:///root@localhost
make docker-compose-down
```

## Wine directory

On startup, a `.wine` directory will be created and setup by wine. This contains the usual wine files, including `drive_c`.

## Docker Notes

The container will run the application as root. You should run in a rootless container, such as `podman`.

The docker container uses `multirun` to run the following on Alpine linux:

- xvfb (virtual framebuffer)
- x11vnc (vnc server)
- wine application (notepad by default, override in `.env`)

You then connect with VNC to `localhost` to access the wine application.

