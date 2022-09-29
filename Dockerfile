FROM gradle:7.4.1-jdk11

ENV ANDROID_VERSION "31"
ENV ANDROID_BUILD_TOOLS_VERSION "30.0.2"
ENV VERSION_SDK_TOOLS "8512546_latest"
ENV ANDROID_SDK_ROOT "/sdk"
ENV GRADLE_PROFILER "/home/gradle/gradle-profiler"
ENV LANG 'en_US.UTF-8'
ENV ANDROID_HOME "/usr/local/sdk"
ENV PATH "$PATH:${ANDROID_SDK_ROOT}/tools:${GRADLE_PROFILER}/build/install/gradle-profiler/bin"

RUN git clone https://github.com/gradle/gradle-profiler.git && \
    cd gradle-profiler && \
    chmod +x ./gradlew && \
    ./gradlew installDist

RUN mkdir "$ANDROID_SDK_ROOT"
RUN cd "$ANDROID_SDK_ROOT" && \
  curl -o sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-${VERSION_SDK_TOOLS}.zip && \
  unzip sdk.zip && \
  rm -v sdk.zip && \
  mv cmdline-tools tools && \
  mkdir cmdline-tools && \
  mv tools cmdline-tools && \
  yes | cmdline-tools/tools/bin/sdkmanager --licenses && \
  cmdline-tools/tools/bin/sdkmanager --update && \
  cmdline-tools/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" && \
  cmdline-tools/tools/bin/sdkmanager "platforms;android-${ANDROID_VERSION}" && \
  cmdline-tools/tools/bin/sdkmanager "platform-tools"

RUN groupadd jenkins_group && useradd --create-home -d "/home/jenkins" -g jenkins_group -u 10000 jenkins_user

RUN chown -R jenkins_user $ANDROID_SDK_ROOT

USER jenkins_user

