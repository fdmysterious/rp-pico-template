FROM alpine:3.18

ARG pico_sdk_version="1.5.0"
ARG username="dev"
ARG uid=1000

# Install tools
RUN apk add --no-cache cmake gcc g++ gcc-arm-none-eabi g++-arm-none-eabi ninja python3 git

# Download and install SDK
RUN mkdir -p /usr/src/
RUN git clone --depth 1 --branch ${pico_sdk_version} https://github.com/raspberrypi/pico-sdk.git /usr/src/pico-sdk

# Export environment variables
ENV PICO_SDK_PATH=/usr/src/pico-sdk

# Create user
RUN adduser ${username} -D -u ${uid}

USER ${username}
WORKDIR /home/${username}
