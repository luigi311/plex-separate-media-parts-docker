FROM plexinc/pms-docker:latest

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        xz-utils \
        wget \
        python3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/lib/plexmediaserver
RUN curl https://raw.githubusercontent.com/Saoneth/plex-custom-audio/master/install.sh | bash

COPY scripts /opt
COPY src/Plex_Separate_Parts_Transcoder/ /usr/lib/plexseparatepartstranscoder/

# Install Separate Parts Transcoder FFMPEG
RUN chmod +x /opt/prepare_image.sh
RUN /opt/prepare_image.sh

# Update plex transcoder
RUN chmod +x /opt/update_transcoder.sh
RUN /opt/update_transcoder.sh