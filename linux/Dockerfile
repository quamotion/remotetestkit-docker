FROM ubuntu:xenial

RUN apt-get update \
&& apt-get install -y wget p7zip-full innoextract unzip \
&& rm -rf /var/lib/apt/lists/*

WORKDIR /src/adb

RUN wget https://www.nuget.org/api/v2/package/runtime.linux.adk-platform-tools/26.0.1 -O runtime.linux.adk-platform-tools-26.0.1.nupkg \
&& unzip runtime.linux.adk-platform-tools-26.0.1.nupkg \
&& chmod +x /src/adb/runtimes/linux/native/adb

WORKDIR /src/rtk

RUN wget https://appkitbox.com/testkit/wp-content/download/remotetestkit-en.exe -O remotetestkit-en.exe \
&& innoextract remotetestkit-en.exe \
&& 7z x app/ThriftApiServer.exe -o/src/rtk/thrift \
&& cp app/lib/*.jar /src/rtk/thrift/

FROM ubuntu:xenial

WORKDIR /

# Install Java and FFmpeg. FFmpeg is used to transcode videos created by Thrift; they can become
# very large and we ues FFmpeg to reduce their size.
RUN apt-get update \
&& apt-get install -y openjdk-8-jre ffmpeg \
&& rm -rf /var/lib/apt/lists/*

COPY run.sh /app/run.sh
COPY --from=0 /src/rtk/thrift /app/
COPY --from=0 /src/adb/runtimes/linux/native/adb /usr/sbin

# Expose default ADB port
EXPOSE 5037

# Expose the RTK Main and Device service
EXPOSE 10048
EXPOSE 10049

# Set the CLASSPATH variable
ENV CLASSPATH="/app:/app/monte.jar"

# Start the server by default
CMD ["/bin/bash", "-c", "/app/run.sh"]
