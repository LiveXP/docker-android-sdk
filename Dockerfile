FROM java:openjdk-7-jdk
MAINTAINER LiveXP <dev@livexp.fr>

ENV ANDROID_SDK_VERSION 24.4.1

RUN update-ca-certificates -f

RUN wget http://dl.google.com/android/android-sdk_r${ANDROID_SDK_VERSION}-linux.tgz && \
    tar zxvf android-sdk_r${ANDROID_SDK_VERSION}-linux.tgz && \
    mv android-sdk-linux /usr/local/bin/android-sdk && \
    rm android-sdk_r${ANDROID_SDK_VERSION}-linux.tgz

ENV ANDROID_HOME /usr/local/bin/android-sdk
ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
