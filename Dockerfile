FROM openjdk:8-jdk
LABEL maintainer="LiveXP <dev@livexp.fr>"

ENV GRADLE_VERSION 4.2
ENV ANDROID_SDK_VERSION 4333796
ENV ANDROID_SDK_PATH /usr/local/bin/android-sdk

RUN update-ca-certificates -f

RUN dpkg --add-architecture i386 && \
    apt-get update -y && \
    apt-get install -y lib32z1 libc6:i386 libncurses5:i386 libstdc++6:i386 expect

COPY bin /usr/local/bin
RUN chmod 755 /usr/local/bin/docker-android-sdk-install
RUN mkdir -p ${ANDROID_SDK_PATH}

RUN wget --quiet https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip && \
    unzip -q sdk-tools-linux-${ANDROID_SDK_VERSION}.zip && \
    mv tools ${ANDROID_SDK_PATH} && \
    rm sdk-tools-linux-${ANDROID_SDK_VERSION}.zip

RUN wget --quiet https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    mkdir /opt/gradle && \
    unzip -q -d /opt/gradle gradle-${GRADLE_VERSION}-bin.zip && \
    rm gradle-${GRADLE_VERSION}-bin.zip

ENV ANDROID_HOME /usr/local/bin/android-sdk
ENV PATH $PATH:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:/opt/gradle/gradle-${GRADLE_VERSION}/bin

RUN mkdir ~/.android && touch ~/.android/repositories.cfg

RUN yes | sdkmanager "platform-tools"
#API for Android 4.x
RUN yes | sdkmanager "platforms;android-19"
#API for Android 5.x
RUN yes | sdkmanager "platforms;android-21"
RUN yes | sdkmanager "platforms;android-22"
#API for Android 6.x
RUN yes | sdkmanager "platforms;android-23"
#API for Android 7.x
RUN yes | sdkmanager "platforms;android-24"
RUN yes | sdkmanager "platforms;android-25"
#API for Android 8.x
RUN yes | sdkmanager "platforms;android-26"
RUN yes | sdkmanager "platforms;android-27"
#API for Android 9.x
RUN yes | sdkmanager "platforms;android-28"

RUN rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get clean
