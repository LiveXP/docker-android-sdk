# Docker Android SDK 

Docker Android image for continuous integration

## Usage

You can use this docker image directly from [Docker Hub](https://hub.docker.com/r/livexp/android-sdk/) with `livexp/docker-android-sdk:latest`.
You can use the script `docker-android-sdk-install` to easily add new dependency to Android SDK.

## Gitlab CI

```yaml
image: livexp/android-sdk:latest

before_script:
  - java -version
  - docker-android-sdk-install extra-android-m2repository,extra-android-support,build-tools-23.0.2

junit-android:
  script:
    - ./gradlew test
  artifacts:
    paths:
      - app/build/reports/tests
```

