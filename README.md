# Android emulator Docker image

Docker image which launches a headless Android emulator

## Build

```
docker build . --tag=android-emulator
```

## Run

```
docker run --privileged --rm -ti --net="host" android-emulator emulator -avd pixel -no-audio -no-window
```
