FROM openjdk:8-jdk
LABEL maintainer="LiveXP <dev@livexp.fr>"

ENV GRADLE_VERSION 4.2
ENV ANDROID_SDK_VERSION 4333796
ENV ANDROID_SDK_PATH /usr/local/bin/android-sdk
ENV ANDROID_API_LEVELS_4.x "platforms;android-19"
ENV ANDROID_API_LEVELS_5.x "platforms;android-20" "platforms;android-21" "platforms;android-22"
ENV ANDROID_API_LEVELS_6.x "platforms;android-23"
ENV ANDROID_API_LEVELS_7.x "platforms;android-24" "platforms;android-25"
ENV ANDROID_API_LEVELS_8.x "platforms;android-26" "platforms;android-27"
ENV ANDROID_API_LEVELS_9.x "platforms;android-28"

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
RUN yes | sdkmanager ${ENV ANDROID_API_LEVELS_4.x}
RUN yes | sdkmanager ${ENV ANDROID_API_LEVELS_5.x}
RUN yes | sdkmanager ${ENV ANDROID_API_LEVELS_6.x}
RUN yes | sdkmanager ${ENV ANDROID_API_LEVELS_7.x}
RUN yes | sdkmanager ${ENV ANDROID_API_LEVELS_8.x}
RUN yes | sdkmanager ${ENV ANDROID_API_LEVELS_9.x}

RUN rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get clean
