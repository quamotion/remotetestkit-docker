FROM microsoft/windowsservercore:1709

ENV chocolateyUseWindowsCompression=false


RUN @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" \
&& SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"



RUN choco config set cachelocation C:\chococache



RUN choco install \

    remotetestkit --version 7.2.1.1 \

    --confirm \

    --limit-output \

    --timeout 216000 \

&& rmdir /S /Q C:\chococache

COPY run.cmd .
CMD [ "run.cmd" ]