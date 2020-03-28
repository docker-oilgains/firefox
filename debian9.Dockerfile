FROM debian:9

ENV DEBIAN_FRONTEND noninteractive

# RUN apt-get update && apt-get install -y wget bzip2 libgtk3.0-cil-dev libdbus-glib-1-2 libdbus-1-3 libasound2 libxt6  libgl1-mesa-glx 
# RUN apt-get install -y --no-install-recommends xserver-xorg-core xserver-xorg-input-all xserver-xorg-video-fbdev
# RUN apt install -y dbus-x11 x11-apps

RUN apt-get update && apt-get install -y wget bzip2 \
    libgtk3.0-cil-dev libdbus-glib-1-2 libxt6


RUN wget --quiet -O /tmp/firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US"
RUN mkdir /opt/firefox && \
    tar xjvf /tmp/firefox.tar.bz2 -C /opt/ && \
    ln -s /opt/firefox/firefox /usr/bin/firefox

# Replace 1000 with your user / group id
RUN export uid=1001 gid=1001 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers && \
    chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer
ENV DISPLAY :0
CMD /usr/bin/firefox
