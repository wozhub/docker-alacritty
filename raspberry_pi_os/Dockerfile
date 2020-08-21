# inspired by https://github.com/wozhub/docker-alacritty

FROM debian:latest as BUILDER

ENV ALACRITTY_VERSION 0.5.0
ENV ALACRITTY_URL https://github.com/alacritty/alacritty/archive/v${ALACRITTY_VERSION}.zip

RUN apt-get update && \
    apt-get -y install \
        cmake \
        pkg-config \
        libfreetype6-dev \
        libfontconfig1-dev \
        libxcb-xfixes0-dev \
        python3 \
	curl \
        unzip

RUN curl -o /tmp/rustup.sh https://sh.rustup.rs && \
    sh /tmp/rustup.sh -y && \
    export PATH="$HOME/.cargo/bin:${PATH}" && \
    rustup override set stable && \
    rustup update stable
    
RUN echo "Downloading ${ALACRITTY_URL}" && \
    curl -o /tmp/alacritty.zip -L "${ALACRITTY_URL}" && \
    cd /tmp && \
    unzip /tmp/alacritty.zip && \
    cd "/tmp/alacritty-${ALACRITTY_VERSION}" && \
    . $HOME/.cargo/env && cargo build --release && \
    cp target/release/alacritty /

FROM alpine 

COPY --from=BUILDER /alacritty /alacritty
