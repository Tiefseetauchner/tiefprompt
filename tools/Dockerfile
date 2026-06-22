FROM debian:stable

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
ENV SOURCE_DATE_EPOCH=1680000000

RUN apt update && apt install -y \
    curl git unzip xz-utils zip libglu1-mesa \
    openjdk-21-jdk \
    clang cmake ninja-build pkg-config libgtk-3-dev \
    && apt clean

RUN useradd -m flutteruser && mkdir -p /home/flutteruser
RUN mkdir -p /app && chown flutteruser /app && chmod 777 /app
RUN mkdir -p /keys && chown flutteruser /keys && chmod 777 /keys

USER flutteruser
WORKDIR /home/flutteruser

ENV PATH="/app/.flutter/bin:$PATH"

RUN mkdir -p /home/flutteruser/android-sdk
ENV ANDROID_HOME="/home/flutteruser/android-sdk"
ENV PATH="$ANDROID_HOME/cmdline-tools/bin:$ANDROID_HOME/platform-tools:$PATH"

RUN curl -o sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip && \
    unzip sdk-tools.zip -d /home/flutteruser/android-sdk && \
    rm sdk-tools.zip

RUN yes | /home/flutteruser/android-sdk/cmdline-tools/bin/sdkmanager --sdk_root=$ANDROID_HOME --licenses && \
    /home/flutteruser/android-sdk/cmdline-tools/bin/sdkmanager --sdk_root=$ANDROID_HOME \
        "platform-tools" \
        "platforms;android-36" \
        "build-tools;37.0.0" \
        "cmdline-tools;latest" \
        "ndk;28.2.13676358" \
        "cmake;4.1.2"

USER flutteruser
WORKDIR /app
CMD ["bash", "-c", "./tools/build.sh -V"]
