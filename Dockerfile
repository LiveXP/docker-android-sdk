FROM java:openjdk-7-jdk
MAINTAINER LiveXP <dev@livexp.fr>

ENV ANDROID_SDK_VERSION 24.4.1
ENV ANDROID_API_LEVELS android-16,android-17,android-18,android-19,android-20,android-21,android-22,android-23
ENV ANDROID_BUILD_TOOLS_VERSION 23.0.2

RUN update-ca-certificates -f

RUN wget http://dl.google.com/android/android-sdk_r${ANDROID_SDK_VERSION}-linux.tgz && \
    tar zxvf android-sdk_r${ANDROID_SDK_VERSION}-linux.tgz && \
    mv android-sdk-linux /usr/local/bin/android-sdk && \
    rm android-sdk_r${ANDROID_SDK_VERSION}-linux.tgz

ENV ANDROID_HOME /usr/local/bin/android-sdk
ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

RUN echo "y" | android update sdk --no-ui --all --filter tools,platform-tools,${ANDROID_API_LEVELS},build-tools-${ANDROID_BUILD_TOOLS_VERSION}

