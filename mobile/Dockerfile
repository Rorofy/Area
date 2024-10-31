FROM cirrusci/flutter:2.10.0
WORKDIR /usr/app
COPY . .

RUN flutter pub get
RUN flutter build apk

RUN chmod +x build.sh
CMD ./build.sh

ENTRYPOINT [ "/bin/bash", "/usr/app/entrypoint.mobile.sh" ]