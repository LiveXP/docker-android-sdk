FROM java:openjdk-8-jdk
MAINTAINER LiveXP <dev@livexp.fr>

ENV ANDROID_SDK_VERSION 3859397
ENV ANDROID_SDK_PATH /usr/local/bin/android-sdk
ENV ANDROID_API_LEVELS "platforms;android-19" "platforms;android-20" "platforms;android-21" "platforms;android-22" "platforms;android-23" "platforms;android-24" "platforms;android-25" "platforms;android-26"

RUN update-ca-certificates -f

RUN dpkg --add-architecture i386 && \
    apt-get update -y && \
    apt-get install -y lib32z1 libc6:i386 libncurses5:i386 libstdc++6:i386 expect

COPY bin /usr/local/bin
RUN chmod 755 /usr/local/bin/docker-android-sdk-install
RUN mkdir -p ${ANDROID_SDK_PATH}

RUN wget https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip && \
    unzip sdk-tools-linux-${ANDROID_SDK_VERSION}.zip && \
    mv tools ${ANDROID_SDK_PATH} && \
    rm sdk-tools-linux-${ANDROID_SDK_VERSION}.zip

ENV ANDROID_HOME /usr/local/bin/android-sdk
ENV PATH $PATH:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

RUN docker-android-sdk-install "platform-tools" ${ANDROID_API_LEVELS}

RUN rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get clean
