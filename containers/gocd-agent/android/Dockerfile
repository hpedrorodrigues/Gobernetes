FROM pracash/gocd-android-agent:latest

RUN /opt/sdk/tools/bin/sdkmanager --update

RUN /opt/sdk/tools/bin/sdkmanager \
  "build-tools;24.0.0" \
  "platforms;android-24"
