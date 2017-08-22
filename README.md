# Docker Android SDK [![Build Status](https://travis-ci.org/LiveXP/docker-android-sdk.svg?branch=master)](https://travis-ci.org/LiveXP/docker-android-sdk)

Docker Android image for continuous integration

## Usage

You can use this docker image directly from [Docker Hub](https://hub.docker.com/r/livexp/android-sdk/) with `livexp/android-sdk:latest`.
You can use the script `docker-android-sdk-install` to easily add new dependency to Android SDK.

## Gitlab CI

```yaml
image: livexp/android-sdk:latest

before_script:
  - java -version
  - docker-android-sdk-install "build-tools;26.0.1" "extras;android;m2repository" "extras;google;m2repository" 

junit-android:
  script:
    - ./gradlew test
  artifacts:
    paths:
      - app/build/reports/tests
```

