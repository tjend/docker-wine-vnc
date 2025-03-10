# Run with multirun:
#   - Xvfb :0 -screen 0 1920x1080x24
#   - x11vnc -display :0 -nopw (after waiting for xvfb to start)
#   - wine application (after waiting for xvfb to start)

FROM docker.io/alpine:latest

ENV APPLICATION="wine notepad"
ENV DISPLAY=":0"

RUN apk --no-cache add \
  # audio
  alsa-utils gst-plugins-good pipewire-alsa \
  # docker init
  multirun \
  # wine
  wine \
  # X11
  x11vnc xterm xvfb

ENTRYPOINT [ "multirun" ]
CMD [ "Xvfb :0 -screen 0 1920x1080x24", "sh -c 'sleep 1 && x11vnc -display :0 -nopw'", "sh -c 'sleep 1 && ${APPLICATION}'" ]
