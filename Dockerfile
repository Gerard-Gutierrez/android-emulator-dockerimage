FROM ubuntu:latest

ENV VERSION_SDK_TOOLS "9477386"
ENV ANDROID_HOME "/sdk"
ENV PATH "$PATH:${ANDROID_HOME}/cmdline-tools/tools/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/emulator"

RUN DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends curl unzip openjdk-17-jdk-headless libgl1 tzdata && \
ln -fs /usr/share/zoneinfo/Europe/Madrid /etc/localtime && \
dpkg-reconfigure -f noninteractive tzdata && \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
curl -ks https://dl.google.com/android/repository/commandlinetools-linux-${VERSION_SDK_TOOLS}_latest.zip > /sdk.zip && \
unzip /sdk.zip -d /output && \
rm -v /sdk.zip && \
mkdir -p /root/.android && \
touch /root/.android/repositories.cfg && \
mkdir -p ${ANDROID_HOME}/cmdline-tools/tools && \
mv /output/cmdline-tools/* ${ANDROID_HOME}/cmdline-tools/tools && \
sdkmanager --update && \
yes | sdkmanager --licenses && \
sdkmanager "build-tools;33.0.2" \
"extras;google;google_play_services" "platform-tools" "platforms;android-33" \
"emulator" "system-images;android-33;google_apis;x86_64" && \
avdmanager create avd -d pixel -n pixel -k "system-images;android-33;google_apis;x86_64"
