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
  - mkdir "$ANDROID_SDK/licenses" || true
    echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_SDK/licenses/android-sdk-license"
    echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > "$ANDROID_SDK/licenses/android-sdk-preview-license"
  - docker-android-sdk-install extra-android-m2repository,extra-android-support,build-tools-23.0.2

junit-android:
  script:
    - ./gradlew test
  artifacts:
    paths:
      - app/build/reports/tests
```

